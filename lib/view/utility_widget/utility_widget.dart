import 'package:battary/utility/my_color.dart';
import 'package:flutter/material.dart';

class UtilityWidget {
  static Container fletButton(Size mysize, {btnText}) {
    return Container(
      width: mysize.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: MyColor.primary, borderRadius: BorderRadius.circular(8)),
      child: Container(
        margin: EdgeInsets.all(20),
        child: Text(
          btnText ?? "CONTINUE",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  // new
  // static InputDecoration myInputDecoration(Size mysize,
  //     {hintText, iconImg, iconPadding, iconSize}) {
  //   return InputDecoration(
  //       hintText: hintText ?? "",
  //       prefixIcon: Container(
  //         padding: EdgeInsets.all(iconPadding ?? 10),
  //         child: Image.asset(
  //           iconImg ?? 'assets/icons/call.png',
  //           height: mysize.height / iconSize,
  //         ),
  //       ));
  // }

  static InputDecoration newInputDecoration({required hintText}) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
    );
  }

  static InputDecoration myInputDecoration(
      {required mysize, required hintText, required iconImg}) {
    return InputDecoration(
        hintText: hintText ?? "",
        counterText: "",
        prefixIcon: Container(
          padding: EdgeInsets.all(10.0),
          child: Image.asset(
            iconImg ?? 'assets/icons/call.png',
            height: mysize.height / 25,
          ),
        ));
  }

  // new
  static InkWell menuStyle(context,
      {required icon, required text, required widgetName()}) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => widgetName()));
      },
      child: Container(
        child: ListTile(
          leading: Icon(
            icon ?? Icons.home,
            color: MyColor.primary,
          ),
          title: Text(text ?? "Home"),
        ),
      ),
    );
  }
}
