import 'package:flutter/material.dart';

class CustomFormTextFiled extends StatelessWidget {
  CustomFormTextFiled({this.hintText, this.onChanged ,this.obscureText=false});
  Function(String)? onChanged;
  String? hintText;
  bool? obscureText ;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (data) {
        if (data!.isEmpty) {
          return 'value is wrong';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w200,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.white,
          ))),
    );
  }
}
