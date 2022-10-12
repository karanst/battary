import 'dart:async';

import 'package:battary/api/api_helper.dart';
import 'package:battary/model/request/replace_new_battary_request.dart';
import 'package:battary/model/request/scan_info_request.dart';
import 'package:battary/model/response/replace_battary_response.dart';
import 'package:battary/model/response/scanInfo_response.dart';
import 'package:battary/token/app_token_data.dart';
import 'package:battary/utility/showDialog.dart';
import 'package:battary/utility/utility_hlepar.dart';
import 'package:battary/view/barcode_scan/scan_new_battary/scan_info_card_view.dart';

import 'package:battary/view/utility_widget/myappbar.dart';
import 'package:battary/view/utility_widget/shimmer_loding_view/loding_all_page.dart';
import 'package:battary/view/utility_widget/utility_widget.dart';
import 'package:flutter/material.dart';
import 'package:battary/utility/my_string.dart' as globals;
class GetOldBattaryInfo extends StatefulWidget {
  String newbarcodeid;
  String oldbarcodeid;
  String productId;
  GetOldBattaryInfo(
      {Key? key, required this.newbarcodeid, required this.oldbarcodeid,required this.productId})
      : super(key: key);

  @override
  _GetOldBattaryInfoState createState() => _GetOldBattaryInfoState();
}

class _GetOldBattaryInfoState extends State<GetOldBattaryInfo> {
  late ScanInfoResponse infoResponse;
  StreamController<ScanInfoResponse>? scanInfoResponse = StreamController();
  late ReplaceBattaryResponse response;
  @override
  void initState() {
    super.initState();
    getScanInfo();
  }

  @override
  void dispose() {
    scanInfoResponse!.close();
  }

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyappBarView(
        appBar: AppBar(),
        titleText: "SCAN DETAILS",
      ),
      body: StreamBuilder<ScanInfoResponse>(
          stream: scanInfoResponse!.stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Container(
                  child: Text(snapshot.error.toString()),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      minHeight: 5,
                    ),
                    LodingAllPage(),
                  ],
                ),
              );
            }
            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: mysize.width / 80),
                child: Column(
                  children: [
                    ScanHistoryCardView(
                      response: snapshot.data!,
                      scanid: widget.newbarcodeid.toString(),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: mysize.height / 25),
                        width: mysize.width * 0.98,
                        child: InkWell(
                          onTap: () {

                              conformation(context, response: snapshot.data!);
                              },
                          child: UtilityWidget.fletButton(mysize,
                              btnText: snapshot.data!.barcodeStatus == 1
                                  ? "Already Active This Battery"
                                  : "Assign New Battary")

                        ))
                  ],
                ),
              ),
            );
          }),
    );
  }

  getScanInfo() async {
    ScanInfoRequest request = ScanInfoRequest(barcodeId: widget.newbarcodeid,);
    infoResponse = await ApiHelper.getScanInfo(request);
    if (infoResponse.status == true) {
      scanInfoResponse!.sink.add(infoResponse);
    } else {
      scanInfoResponse!.sink.addError(infoResponse.message.toString());
    }
  }

  conformation(context, {required ScanInfoResponse response}) {
    if (response.barcodeStatus != 1) {
      MyDialogBox.showAlertDialogWithTwobtn(
        context,
        body: "Do you want to assign new Battary",
        title: "Are you sure you ?",
        funtionName: () {
          globals.open = false;
          assentNewBattary();
        },
      );
    } else {
      UtilityHlepar.getToast("Already Active This Battery");
    }
  }
  // Navigator.push(context,
  //     MaterialPageRoute(builder: (context) => GetOldCustomerDetails()));

  assentNewBattary() async {
    var userid = await MyToken.getUserID();
    ReplaceBattaryRequest request = ReplaceBattaryRequest(
        newBarcodeId: widget.newbarcodeid, oldBarcodeId: widget.oldbarcodeid,userId: userid);
    print(request.tojson());
    response = await ApiHelper.replaceBattary(request);
    if (response.status == true) {
      Navigator.pop(context);
      Navigator.pop(context);
      //open = true;
    }
  }
}
