import 'package:battary/api/api_helper.dart';
import 'package:battary/model/request/scan_history_info_request.dart';
import 'package:battary/model/response/scan_history_response.dart';
import 'package:battary/token/app_token_data.dart';
import 'package:battary/utility/my_color.dart';
import 'package:battary/view/scan_history/scan_details_info.dart';
import 'package:battary/view/scan_history/scan_history_card.dart';
import 'package:battary/view/utility_widget/shimmer_loding_view/loding_all_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomeLatestScanHistory extends StatefulWidget {
  //  HomeLatestScanHistory({Key? key}) : super(key: key);
  @override
  _HomeLatestScanHistoryState createState() => _HomeLatestScanHistoryState();
}

class _HomeLatestScanHistoryState extends State<HomeLatestScanHistory> {
  late ScanHistoryResponse response;
  List scanIds = [];
  String? ids;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    return FutureBuilder(
        future: getScanHistory(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Container(
                  // child: Text(ToastString.msgScanHistoryError),
                  ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return LodingAllPage();
          }
          return Container(
            margin: EdgeInsets.symmetric(
                horizontal: mysize.width / 40.0, vertical: mysize.height / 60),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: mysize.height / 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Latest scan history",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: MyColor.primary),
                      ),
                    ],
                  ),
                ),
                AnimationLimiter(
                  child: ListView.builder(
                    itemCount: response.data!.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {

                      scanIds.add(response.data![index].newBarcodeId);
                      ids = scanIds.join('|');
                      print("ids are ${ids}");

                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 650),
                        child: ScaleAnimation(
                          // verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: InkWell(
                                onTap: (){
                                    onTapGoNextScreen(context, index: index);
                                },
                                child: ScanHistoryCard(
                                    response: response, i: index)),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // MyBattaryCard.scanHistoryCardView(mysize)
              ],
            ),
          );
        });
  }

  getScanHistory() async {
    var userid = await MyToken.getUserID();
    ScanHistoryRequest request = ScanHistoryRequest(userid: userid.toString());
    response = await ApiHelper.scanHistory(request);
    return response;
  }

  onTapGoNextScreen(context, {index}) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MainScanDetailInfo(
                  i: index,
                  response: response,
                )));
            setState(() {});
  }

  Container cardRow({required title, required value}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            title ?? "",
            style: TextStyle(color: MyColor.primary),
          ),
          Text(
            value,
            style: TextStyle(
                color: MyColor.primaryLight, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
