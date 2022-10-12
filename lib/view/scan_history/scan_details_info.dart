import 'package:battary/model/response/scan_history_response.dart';
import 'package:battary/utility/my_color.dart';
import 'package:battary/utility/utility_hlepar.dart';
import 'package:battary/view/complain_view/complain_box.dart';
import 'package:battary/view/scan_history/scan_details_request_list.dart';
import 'package:battary/view/scan_history/scan_history_card.dart';
import 'package:battary/view/utility_widget/battary_card_view.dart';
import 'package:battary/view/utility_widget/myappbar.dart';
import 'package:battary/view/utility_widget/utility_widget.dart';
import 'package:flutter/material.dart';

class MainScanDetailInfo extends StatelessWidget {
  ScanHistoryResponse response;
  int i;
  MainScanDetailInfo({Key? key, required this.response, required this.i})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: MyappBarView(
          appBar: AppBar(),
          titleText: "Scan Details",
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: mysize.width / 40, vertical: mysize.height / 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // MyBattaryCard.scanHistoryCardView(mysize),
                ScanHistoryCard(response: response, i: i),

                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: mysize.width / 60,
                      vertical: mysize.height / 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order details",
                        style: TextStyle(fontSize: 15),
                      ),
                      cardRow(mysize,
                          title: "Scan id",
                          value: UtilityHlepar.convertNA(
                              response.data![i].barcodeId)),
                      response.data![i].newBarcodeStatus == "0"
                          ? Container()
                          : cardRow(mysize,
                              title: "New Scan id",
                              value: UtilityHlepar.convertNA(
                                  response.data![i].newBarcodeId)),
                      cardRow(mysize,
                          title: "Date",
                          value: UtilityHlepar.convertNA(
                              response.data![i].scanningDate)),
                      cardRow(mysize,
                          title: "Name",
                          value:
                              UtilityHlepar.convertNA(response.data![i].name)),
                      cardRow(mysize,
                          title: "Email",
                          value: UtilityHlepar.convertNA(response.data![i].email)),
                      cardRow(mysize,
                          title: "Phone",
                          value:
                              UtilityHlepar.convertNA(response.data![i].phone)),
                      ScanDetailsRequestList(response: response, i: i)
                      // InkWell()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Container cardRow(Size mysize, {required title, required value}) {
  return Container(
    child: Row(
      children: [
        SizedBox(
          width: mysize.width / 3,
          child: Container(
            margin: EdgeInsets.only(right: 20),
            child: Text(
              title ?? "",
              style: TextStyle(
                  color: MyColor.primaryLight, fontWeight: FontWeight.w500),
            ),
          ),
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
