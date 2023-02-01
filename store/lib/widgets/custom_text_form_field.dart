import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {this.hintText, this.inputType, this.onChanged, this.isObscure = false});
  Function(String)? onChanged;
  String? hintText;
  bool? isObscure;
  TextInputType? inputType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // validator: (value) {
      //   if (value!.isEmpty) return 'Field is required';
      // },
      keyboardType: inputType,
      onChanged: onChanged,
      obscureText: isObscure!,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
