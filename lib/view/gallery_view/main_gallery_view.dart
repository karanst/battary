import 'dart:async';

import 'package:battary/api/api_helper.dart';
import 'package:battary/model/response/image_gallery_response.dart';
import 'package:battary/utility/toast_string.dart';
import 'package:battary/view/utility_widget/myappbar.dart';
import 'package:battary/view/utility_widget/shimmer_loding_view/loding_all_page.dart';
import 'package:flutter/material.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';

final urls = [
  'https://via.placeholder.com/400',
  'https://via.placeholder.com/800',
  'https://via.placeholder.com/900x350',
  'https://via.placeholder.com/1000',
  'https://via.placeholder.com/100',
];

final remoteImages = [
  Image.network('https://via.placeholder.com/400'),
  Image.network('https://via.placeholder.com/800'),
  Image.network('https://via.placeholder.com/900x350'),
  Image.network('https://via.placeholder.com/1000'),
  Image.network('https://via.placeholder.com/100'),
];

// final assets = const [
// Image(image: NetworkImage('https://via.placeholder.com/400')),
//   Image(image: NetworkImage('https://via.placeholder.com/400')),
//   Image(image: NetworkImage('https://via.placeholder.com/400')),
//   Image(image: NetworkImage('https://via.placeholder.com/400')),
// ];

class ImageGalleryView extends StatefulWidget {
  // ImageGalleryView({Key? key, }) : super(key: key);

  @override
  _ImageGalleryViewState createState() => _ImageGalleryViewState();
}

class _ImageGalleryViewState extends State<ImageGalleryView> {
  late ImageGalleryResponse response;
  StreamController<ImageGalleryResponse> imgResponseStream = StreamController();
  final heroProperties = [
    ImageGalleryHeroProperties(tag: 'imageId1'),
    ImageGalleryHeroProperties(tag: 'imageId2'),
  ];
  List<Image> mainImgList = [];
  List<ImageGalleryHeroProperties> heroImgList = [];
  @override
  void initState() {
    super.initState();
    getImageGallery();
  }

  @override
  void deactivate() {
    super.deactivate();
    imgResponseStream.close();
  }

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyappBarView(
        appBar: AppBar(),
        titleText: "My Gallery",
      ),
      body: StreamBuilder<ImageGalleryResponse>(
          stream: imgResponseStream.stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return LodingAllPage();
            }
            return GridView.builder(
              itemCount: snapshot.data!.data!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (BuildContext context, int i) {
                return Padding(
                  padding: EdgeInsets.all(mysize.width / 60),
                  child: InkWell(
                    onTap: () => SwipeImageGallery(
                      context: context,
                      images: mainImgList,
                      initialIndex: i,
                      heroProperties: heroImgList,
                    ).show(),
                    child: Hero(
                      tag: '$i',
                      child: Image(
                        image: NetworkImage(snapshot.data!.basePath.toString() +
                            snapshot.data!.data![i].image.toString()),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }

  getImageGallery() async {
    response = await ApiHelper.getImageGallery();
    for (var i = 0; i < response.data!.length; i++) {
      mainImgList.add(Image(
          image: NetworkImage(response.basePath.toString() +
              response.data![i].image.toString())));

      // 2 number
      heroImgList.add(
        ImageGalleryHeroProperties(tag: '$i'),
      );
    }
    imgResponseStream.sink.add(response);

    // if (response.status!) {
    //   imgResponseStream.sink.add(response);
    // } else {
    //   imgResponseStream.sink.addError(response.message.toString());
    // }
    setState(() {});
    // } catch (e) {
    //   // imgResponseStream.sink.addError(ToastString.msgSomeWentWrong);
    // }
  }
}
