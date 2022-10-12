import 'package:battary/api/api_helper.dart';
import 'package:battary/model/request/scan_form_request.dart';
import 'package:battary/model/response/scan_from_response.dart';
import 'package:battary/token/app_token_data.dart';
import 'package:battary/utility/showDialog.dart';
import 'package:battary/validation/form_validation.dart';
import 'package:battary/view/scan_history/main_scan_history.dart';
import 'package:battary/view/utility_widget/myappbar.dart';
import 'package:battary/view/utility_widget/utility_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScanCustomerForm extends StatelessWidget {
  String scanid;
  String warrantyDate;
  ScanCustomerForm({Key? key, required this.scanid, required this.warrantyDate})
      : super(key: key);
  GlobalKey<FormState> _fromkey = GlobalKey<FormState>();
  TextEditingController fastName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyappBarView(
        appBar: AppBar(),
        titleText: "CUSTOMER FORM",
      ),
      body: Form(
        key: _fromkey,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: 10.0, horizontal: mysize.width / 25),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: mysize.width * 0.45,
                      child: TextFormField(
                        controller: fastName,
                        // validator: FormValidation.checkEmptyValidator,
                        decoration: UtilityWidget.newInputDecoration(
                            hintText: "First Name ( optional )"),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp('[a-z,A-Z]')),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: mysize.width * 0.45,
                      child: TextFormField(
                        controller: lastName,
                        // validator: FormValidation.checkEmptyValidator,
                        decoration: UtilityWidget.newInputDecoration(
                            hintText: "Last Name ( optional ) "),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp('[a-z,A-Z]')),
                        ],
                      ),
                    )
                  ],
                ),
                //new row
                Container(
                  margin: EdgeInsets.symmetric(vertical: mysize.height / 35),
                  child: TextFormField(
                    maxLength: 10,
                    controller: phoneNumber,
                    keyboardType: TextInputType.number,
                    validator: FormValidation.validateMobile,
                    decoration: UtilityWidget.newInputDecoration(
                        hintText: "Phone Number"),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                //new row
                //new row
                Container(
                  child: TextFormField(
                    controller: emailAddress,
                    keyboardType: TextInputType.emailAddress,
                    // validator: FormValidation.EmailVeledetion,
                    decoration: UtilityWidget.newInputDecoration(
                        hintText: "Email Address ( optional )"),
                  ),
                ),
                //new row

                Container(
                    margin: EdgeInsets.symmetric(vertical: mysize.height / 35),
                    child: InkWell(
                        onTap: () => submitFormField(context),
                        child: UtilityWidget.fletButton(mysize))),
              ],
            ),
          ),
        ),
      ),
    );
  }

// submit form field
  submitFormField(context) async {
    print(warrantyDate);
    if (_fromkey.currentState!.validate()) {
      MyDialogBox.loadingDialog(context);
      var userid = await MyToken.getUserID();
      ScanFormRequest request = ScanFormRequest(
          fastName: fastName.text.isNotEmpty ? fastName.text : "N/A",
          lastName: lastName.text.isNotEmpty ? lastName.text : "N/A",
          phoneNumber: phoneNumber.text,
          email: emailAddress.text.isNotEmpty ? emailAddress.text : "N/A",
          barcodeId: scanid,
          userid: userid,
          warrantyData: warrantyDate);
      ScanFromResponse response = await ApiHelper.submitScanFrom(request);
      if (response.status == true) {
        onTapGoNextscreen(context);
      }
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  onTapGoNextscreen(context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainScanHistory()));
  }
}
