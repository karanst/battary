import 'package:battary/utility/my_color.dart';
import 'package:flutter/material.dart';

import '../view/scan_history/scan_details_request_list.dart';

class MyDialogBox {
  static Future<void> showMyDialog(context,
      {required title, bodyText, required functionName}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(bodyText ?? ''),
                // Text('So please  '),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(child: Text('Yes'),
                onPressed: () => functionName()),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static showAlertDialogWithTwobtn(BuildContext context,
      {String? title, String? body, String? bta, Function? funtionName}) {
    Widget oknot = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var mysize = MediaQuery.of(context).size;
        return Container(
          margin: EdgeInsets.symmetric(vertical: mysize.height / 3),
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(60),
                    bottomLeft: Radius.circular(60)),
                child: Container(
                  width: mysize.height * 0.4,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text(
                          title!,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        )),
                        Container(
                            margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                            child: Text(body!)),
                        // butn
                        Spacer(),
                        Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 30,
                                  width: 60,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "NO",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                ),
                              ),
                              InkWell(
                                // onTap: () => funtionName!(),
                                onTap: () {
                                  Navigator.pop(context);
                                  // funtionName!();
                                  _showMyDialog(context, "Your Request Save", funtionName);
                                },
                                child: Container(
                                  height: 30,
                                  width: 60,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text(
                                    "YES",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static _showMyDialog(context, msg, Function? functionName) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('You Request Save'),
          actions: <Widget>[
            TextButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.pop(context);
                functionName!();
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ScanDetailsRequestList(i: ,response: "",)));
              },
            ),
          ],
        );
      },
    );
  }

// loading Dialog
  static loadingDialog(BuildContext context) {
    var Mysize = MediaQuery.of(context).size;
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: new Stack(
            children: <Widget>[
              new Container(
                alignment: AlignmentDirectional.center,
                decoration: new BoxDecoration(
                  color: Colors.white70,
                ),
                child: new Container(
                  decoration: new BoxDecoration(
                      color: MyColor.primary,
                      borderRadius: new BorderRadius.circular(10.0)),
                  width: 300.0,
                  height: 200.0,
                  alignment: AlignmentDirectional.center,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Center(
                        child: new SizedBox(
                          height: 50.0,
                          width: 50.0,
                          child: new CircularProgressIndicator(
                            value: null,
                            strokeWidth: 7.0,
                          ),
                        ),
                      ),
                      new Container(
                        margin: const EdgeInsets.only(top: 25.0),
                        child: new Center(
                          child: new Text(
                            "loading.. wait...",
                            style: new TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
