import 'package:battary/api/api_helper.dart';
import 'package:battary/model/request/complent_box_request.dart';
import 'package:battary/model/response/complain_box_response.dart';
import 'package:battary/model/response/scan_history_response.dart';
import 'package:battary/token/app_token_data.dart';
import 'package:battary/utility/showDialog.dart';
import 'package:battary/validation/form_validation.dart';
import 'package:battary/view/utility_widget/myappbar.dart';
import 'package:battary/view/utility_widget/utility_widget.dart';
import 'package:flutter/material.dart';
import 'package:battary/utility/my_string.dart' as globals;
class CmplainBox extends StatelessWidget {
  Widget batteryCard;
  ScanHistoryResponse response;
  int i;

  CmplainBox(
      {Key? key,
      required this.batteryCard,
      required this.response,
      required this.i})
      : super(key: key);

  GlobalKey<FormState> _fromkey = GlobalKey<FormState>();
  TextEditingController descriptionController = TextEditingController();
  late ComplentBoxResponse _complentBoxResponse;

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyappBarView(
        appBar: AppBar(),
        titleText: 'Complaint Box',
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: mysize.height / 70),
          child: Form(
            key: _fromkey,
            child: Column(
              children: [
                batteryCard,
                SizedBox(
                  height: mysize.height / 40,
                ),
                SizedBox(
                  height: mysize.height / 3,
                  child: TextFormField(
                    controller: descriptionController,
                    keyboardType: TextInputType.multiline,
                    validator: FormValidation.checkEmptyValidator,
                    // minLines: 1, //Normal textInputField will be displayed
                    maxLines: 15, // when user presses enter it will adapt to it
                    decoration: UtilityWidget.newInputDecoration(
                        hintText: "Provide your feedback"),
                  ),
                ),
                SizedBox(
                  height: mysize.height / 25,
                ),
                InkWell(
                    onTap: () {
                      globals.open = true;
                      onTapComplein(context);
                    },
                    child: UtilityWidget.fletButton(mysize))
              ],
            ),
          ),
        ),
      ),
    );
  }

  onTapComplein(context) async {
    if (_fromkey.currentState!.validate()) {
      MyDialogBox.loadingDialog(context);
      var userId = await MyToken.getUserID();
      var roleId = await MyToken.getRoleId();
      var newCode;
      var initalId = response.data![i].barcodeId.toString();
      var barcodeId = response.data![i].barcodeId.toString();
      var customerid = response.data![i].custId.toString();
      newCode = response.data![i].newBarcodeId.toString();
      // if(response.data![i].newBarcodeId.toString() != "0"){
      //   newCode = response.data![i].newBarcodeId.toString();
      // }
      ComplentBoxRequest request = ComplentBoxRequest(
          roleId: roleId.toString(),
          machanicId: userId,
          customerid: customerid,
          barcodeId: barcodeId,
          description: descriptionController.text,
          newBarcodeId: newCode,
          initialId: initalId
      );
      print(request);
      _complentBoxResponse = await ApiHelper.issueWithBatter(request);
      Navigator.pop(context);
      if (_complentBoxResponse.status == true) {
        Navigator.pop(context);
      }
    }
  }
}
