import 'dart:async';

import 'package:battary/api/api_helper.dart';
import 'package:battary/model/request/get_Issue_request.dart';
import 'package:battary/model/response/issue_history_response.dart';
import 'package:battary/model/response/scan_history_response.dart';
import 'package:battary/utility/my_string.dart';
import 'package:battary/utility/utility_hlepar.dart';
import 'package:battary/view/barcode_scan/scan_old_battary/scan_old_battary.dart';
import 'package:battary/view/complain_view/complain_box.dart';
import 'package:battary/view/scan_history/scan_history_card.dart';
import 'package:battary/view/utility_widget/shimmer_loding_view/loding_all_page.dart';
import 'package:battary/view/utility_widget/utility_widget.dart';
import 'package:flutter/material.dart';

import '../../token/app_token_data.dart';
import 'package:battary/utility/my_string.dart' as globals;
class ScanDetailsRequestList extends StatefulWidget {
  ScanHistoryResponse response;
  int i;
  ScanDetailsRequestList({Key? key, required this.response, required this.i})
      : super(key: key);

  @override
  _ScanDetailsRequestListState createState() => _ScanDetailsRequestListState();

}

class _ScanDetailsRequestListState extends State<ScanDetailsRequestList> {

  late StreamController<IssueHistoryResponse> issueHistoryStream =
      StreamController();
  late IssueHistoryResponse historyResponse;

  @override
  void initState() {
    super.initState();
    getIssueHistory();
  }

  @override
  void dispose() {
    super.dispose();
    issueHistoryStream.close();
  }

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    return StreamBuilder<IssueHistoryResponse>(
        stream: issueHistoryStream.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return // btn
                button(mysize, context, buttonText: 'issue with battery ');
            // btn
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return LodingAllPage();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.symmetric(vertical: mysize.height / 60),
                  child: Text("Request Info")),
              ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: snapshot.data!.data!.length,
                  itemBuilder: (context, int i) {
                    int lastindex = snapshot.data!.data!.length - 1;
                    print("List is @@ ${snapshot.data!.data!.length}");
                    return InkWell(
                        onTap: () {
                          if(lastindex == i){
                            print("BARCODE ID :::::::????==== ${widget.response.data![widget.i].newBarcodeId}");
                            replaceBattary(barcodeid: snapshot.data!.data![i].barcodeId);

                          }
                          // replaceBattary(barcodeid: widget.response.data![widget.i].newBarcodeId);
                          // snapshot.data!.data!.lastIndexOf(i);
                        },
                        child: requestListBody(mysize, snapshot, i));
                  }),
              // btn
             // snapshot.data!.data!.length == 0 ?
                 // count == 1 ?
              globals.open == true ?
                //  count == 1?
                  Container(
                    width: mysize.width,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey, borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                        "REPORT OTHER ISSUE",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ),
                  )
            :  button(mysize, context, buttonText: 'report other issue')
              // btn
            ],
          );
        });
  }

  Container requestListBody(
      Size mysize, AsyncSnapshot<IssueHistoryResponse> snapshot, int i) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: mysize.height / 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Data : " +
              UtilityHlepar.convertNA(
                  snapshot.data!.data![i].replecementDate.toString())),
          Container(
            child: Text('Description : ' +
                UtilityHlepar.convertNA(
                    snapshot.data!.data![i].description.toString())),
          ),
          SizedBox(height: 5,),
          Text("Tap On Details to Assign New Battery"),
          SizedBox(height: 5,),
        ],
      ),
    );
  }

  Container button(Size mysize, BuildContext context, {required buttonText}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: mysize.height / 60),
      child: InkWell(
          onTap: () => issueWithBattery(context),
          child: UtilityWidget.fletButton(mysize,
              btnText: buttonText.toUpperCase())),
    );
  }

  void getIssueHistory() async {
    var barcodeId = widget.response.data![widget.i].barcodeId.toString();
    var userid = await MyToken.getUserID();
    IssueHistoryRequest request = IssueHistoryRequest(userId: userid, barcodeId: barcodeId);
    historyResponse = await ApiHelper.getIssueHistory(request);
    if (historyResponse.status == true) {
      issueHistoryStream.sink.add(historyResponse);

    } else {
      issueHistoryStream.sink.addError("error");
    }
  }

  issueWithBattery(context) async {
    // if (widget.response.data![widget.i].newBarcodeStatus == "0") {
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CmplainBox(
                    response: widget.response,
                    i: widget.i,
                    batteryCard: ScanHistoryCard(response: widget.response, i: widget.i),
                  )
          )
      );
      Navigator.pop(context);
    // } else {
    //   UtilityHlepar.getToast("Already Assign New Battary");
    // }
  }

// replace & scan Battary
  replaceBattary({required barcodeid}) async {
    print(barcodeid);
    print([widget.i]);
    // if (widget.response.data![widget.i].newBarcodeStatus == "0") {
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SacnOldBattary(
                    oldbarcodeid: barcodeid,
                    productId : widget.response.data![widget.i].productId.toString(),
                  )
          )
      );
      print("=========Battary Scan done");
   //   Navigator.pop(context);
   //  } else {
   //    UtilityHlepar.getToast("Already Assign New Battary");
   //  }
  }
}
