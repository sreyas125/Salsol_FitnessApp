import 'package:flutter/material.dart';

class CustomTextFieldtwo extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final IconData? suffixicon;
  final void Function()? onPressed;
  final bool? boolValue;

   const CustomTextFieldtwo({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator, 
    this.keyboardType, 
    this.suffixicon,
    this.onPressed, this.boolValue,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: TextFormField(keyboardType: keyboardType,
            controller: controller,enabled: boolValue,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(suffixIcon: IconButton(onPressed: () {onPressed;
            }, icon: Icon(suffixicon)),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.0),
                borderSide: const BorderSide(color: Colors.blue),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
