import 'package:battary/utility/my_color.dart';
import 'package:battary/view/barcode_scan/scan_new_battary/main_scan_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class MainBarcodeScannerView extends StatefulWidget {
  const MainBarcodeScannerView({Key? key}) : super(key: key);

  @override
  _MainBarcodeScannerViewState createState() => _MainBarcodeScannerViewState();
}

class _MainBarcodeScannerViewState extends State<MainBarcodeScannerView> {
  @override
  void initState() {
    super.initState();
    scanBarcode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: CircularProgressIndicator(
        color: MyColor.primary,
      )),
    );
  }

  Future scanBarcode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    print("barcodes1===="+barcodeScanRes);
    if(barcodeScanRes==null||barcodeScanRes=="-1"){
      Navigator.pop(context);
    }else{
      goNextScreen(scanid: barcodeScanRes);
    }

    // print(barcodeScanRes);
  }

  goNextScreen({scanid}) {
    if (scanid != null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MainScanDetails(
                    scanid: scanid,
                  )));
    } else {
      scanBarcode();
    }
  }
}
