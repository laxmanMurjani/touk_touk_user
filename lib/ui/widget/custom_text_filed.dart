import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:etoUser/util/app_constant.dart';

class CustomTextFiled extends StatelessWidget {
  TextEditingController? controller;
  String? label;
  String? hint;
  InputBorder? border;
  InputBorder? focusedBorder;
  InputBorder? enabledBorder;
  Color? fillColor;
  bool? filled;
  Widget? labelWidget;
  TextStyle? hintStyle;
  TextInputType inputType;
  bool isPassword;
  bool readOnly;
  Widget? suffixIcon;
  List<TextInputFormatter>? inputFormatter;
  TextCapitalization textCapitalization;
  CustomTextFiled(
      {this.controller,
      this.label,
      this.labelWidget,
      this.hintStyle,
      this.filled = false,
      this.hint,
      this.fillColor,
      this.border,
      this.enabledBorder,
      this.focusedBorder,
      this.inputType = TextInputType.text,
      this.isPassword = false,
      this.readOnly = false,
      this.suffixIcon,
      this.inputFormatter,
      this.textCapitalization = TextCapitalization.none});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      inputFormatters: inputFormatter,
      decoration: InputDecoration(
        label: labelWidget,
        hintText: hint,
        hintStyle: TextStyle(
            fontSize: 10.sp, color: Colors.black, fontWeight: FontWeight.w500),
        // labelText: label ?? "",
        labelStyle:
            hintStyle ?? TextStyle(fontSize: 10.sp, color: Color(0xffB4B4B5)),
        border: border,
        filled: filled,
        fillColor: fillColor,
        isDense: true,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: enabledBorder ??
            UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
        suffixIcon: suffixIcon,
      ),
      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
      keyboardType: inputType,
      readOnly: readOnly,
      textCapitalization: textCapitalization
    );
  }
}
