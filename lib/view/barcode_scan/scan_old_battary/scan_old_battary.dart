import 'dart:async';
import 'dart:convert';

import 'package:battary/api/api_path.dart';
import 'package:battary/utility/utility_hlepar.dart';
import 'package:battary/view/barcode_scan/scan_old_battary/get_old_battary_info.dart';
import 'package:battary/view/utility_widget/myappbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;

import '../../scan_history/scan_details_request_list.dart';
class SacnOldBattary extends StatefulWidget {
  String oldbarcodeid;
  String productId;
  SacnOldBattary({Key? key, required this.oldbarcodeid,required this.productId}) : super(key: key);

  @override
  _SacnOldBattaryState createState() => _SacnOldBattaryState();
}

class _SacnOldBattaryState extends State<SacnOldBattary> {
  StreamController<String> _scanStreamController = StreamController();
  var myBarcode;
  @override
  void initState() {
    super.initState();
    getScanBarcode();
  }

  @override
  void dispose() {
    super.dispose();
    _scanStreamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyappBarView(
        appBar: AppBar(),
        titleText: "Scan & Replace",
      ),
      body: StreamBuilder<String>(
          stream: _scanStreamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
              // getScanBarcode();
            }
            return Container(
              child: Center(child: LinearProgressIndicator()),
            );
          }),
    );
  }

  Future getScanBarcode() async {
    myBarcode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    print("barcodes2==="+ myBarcode);
    if(myBarcode == "-1" || myBarcode == null){
        Navigator.pop(context);
    }else{
      var response  = await http.post(Uri.parse(Apipath.get_product_details_scan),
          body: {
        "barcode_id":myBarcode,
        "product_id":widget.productId,
      });
      print("BAR CODE ID === $myBarcode");
      print("PRODUCT ID === ${widget.productId}");
      Map data = jsonDecode(response.body);
      print("barcodes2"+data.toString());
      if(data['status']){
        goNextScreen(scanid: myBarcode);
      }else{
        Navigator.pop(context);
        _showMyDialog(context, data['message'].toString());
        // UtilityHlepar.getToast(data['message'].toString());
      }
    }
    _scanStreamController.sink.add(myBarcode);

    print("================");
    print(widget.oldbarcodeid);

    print(myBarcode);
    print("================");
  }

  Future<void> _showMyDialog(context, msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$msg'),
          actions: <Widget>[
            TextButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  goNextScreen({scanid}) {
    if (scanid != null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => GetOldBattaryInfo(
                    newbarcodeid: scanid,
                    oldbarcodeid: widget.oldbarcodeid,
                    productId : widget.productId,
                  )));
    } else {
      getScanBarcode();
    }
  }
}
