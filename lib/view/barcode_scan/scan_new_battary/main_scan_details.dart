import 'dart:async';

import 'package:battary/api/api_helper.dart';
import 'package:battary/model/request/scan_info_request.dart';
import 'package:battary/model/response/scanInfo_response.dart';
import 'package:battary/token/app_token_data.dart';
import 'package:battary/utility/utility_hlepar.dart';
import 'package:battary/view/barcode_scan/scan_new_battary/customer_form.dart';
import 'package:battary/view/barcode_scan/scan_new_battary/scan_info_card_view.dart';
import 'package:battary/view/utility_widget/myappbar.dart';
import 'package:battary/view/utility_widget/shimmer_loding_view/loding_all_page.dart';
import 'package:battary/view/utility_widget/utility_widget.dart';
import 'package:flutter/material.dart';

class MainScanDetails extends StatefulWidget {
  String scanid;
  MainScanDetails({Key? key, required this.scanid}) : super(key: key);

  @override
  _MainScanDetailsState createState() => _MainScanDetailsState();
}

class _MainScanDetailsState extends State<MainScanDetails> {
  late ScanInfoResponse infoResponse;

  StreamController<ScanInfoResponse>? scanInfoResponse = StreamController();

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
              return LodingAllPage();
            }
            return Container(
              margin: EdgeInsets.symmetric(horizontal: mysize.width / 80),
              child: Column(
                children: [
                  ScanHistoryCardView(
                    response: snapshot.data!,
                    scanid: widget.scanid.toString(),
                  ),
                  snapshot.data!.barcodeStatus == 1
                      ? InkWell(
                          onTap: () {
                            UtilityHlepar.getToast(
                                snapshot.data!.message.toString());
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: mysize.height / 25,
                                horizontal: mysize.width / 60),
                            child: UtilityWidget.fletButton(mysize,
                                btnText: snapshot.data!.message),
                          ),
                        )
                      : Container(
                          // height: mysize.height / 15,
                          margin: EdgeInsets.only(top: mysize.height / 25),
                          width: mysize.width * 0.98,
                          child: InkWell(
                            onTap: () =>
                                onTapGoNextScreen(context, snapshot.data),
                            child: UtilityWidget.fletButton(mysize,
                                btnText: "Start Warranty"),
                          ))
                ],
              ),
            );
          }),
    );
  }

  getScanInfo() async {
    ScanInfoRequest request = ScanInfoRequest(barcodeId: widget.scanid);
    infoResponse = await ApiHelper.getScanInfo(request);
    if (infoResponse.status == true) {
      scanInfoResponse!.sink.add(infoResponse);
    } else {
      scanInfoResponse!.sink.addError(infoResponse.message.toString());
    }
  }

  onTapGoNextScreen(context, response) async {
    var userid = await MyToken.getUserID();
    print(userid);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ScanCustomerForm(
                  scanid: widget.scanid.toString(),
                  warrantyDate: response.data![0].warrantyInfo!.toDate.toString(),
                )));
  }
}
