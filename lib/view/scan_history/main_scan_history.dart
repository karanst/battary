import 'dart:async';

import 'package:battary/api/api_helper.dart';
import 'package:battary/model/request/scan_history_info_request.dart';
import 'package:battary/model/response/scan_history_response.dart';
import 'package:battary/token/app_token_data.dart';
import 'package:battary/utility/toast_string.dart';
import 'package:battary/view/scan_history/scan_details_info.dart';
import 'package:battary/view/scan_history/scan_history_card.dart';
import 'package:battary/view/utility_widget/battary_card_view.dart';
import 'package:battary/view/utility_widget/myappbar.dart';
import 'package:battary/view/utility_widget/shimmer_loding_view/loding_all_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class MainScanHistory extends StatefulWidget {
  MainScanHistory({Key? key}) : super(key: key);

  @override
  _MainScanHistoryState createState() => _MainScanHistoryState();
}

class _MainScanHistoryState extends State<MainScanHistory> {
  late ScanHistoryResponse response;

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyappBarView(
        appBar: AppBar(),
        titleText: "SCAN HISTORY",
      ),
      body: FutureBuilder(
          future: getScanHistory(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                  child:
                      Container(child: Text(ToastString.msgScanHistoryError)));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LodingAllPage();
            }
            return AnimationLimiter(
              child: ListView.builder(
                itemCount: response.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 650),
                    child: ScaleAnimation(
                      child: FadeInAnimation(
                        child: InkWell(
                          onTap: () => onTapGoNextScreen(context, index: index),
                          child: ScanHistoryCard(
                            i: index,
                            response: response,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
    );
  }

  getScanHistory() async {
    var userid = await MyToken.getUserID();
    ScanHistoryRequest request = ScanHistoryRequest(userid: userid);
    response = await ApiHelper.scanHistory(request);
    return response;
  }

  onTapGoNextScreen(context, {index}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MainScanDetailInfo(
                  i: index,
                  response: response,
                )));
  }
}
