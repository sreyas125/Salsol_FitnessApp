import 'package:flutter/material.dart';

// ignore: camel_case_types
class customTextField extends StatefulWidget {
  final String texthint;
  final IconData icon;
  final TextEditingController emailcontroller;
  final String? Function(dynamic value) validator;

   const customTextField({
    Key? key,
    required this.texthint,
    required this.emailcontroller,
    required this.icon, 
    required this.validator,
   }) :super(key: key);

  @override
  State<customTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<customTextField> {
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
              //width: 420,
               child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: widget.emailcontroller,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: widget.texthint,
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: Icon(widget.icon),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: const BorderSide(color: Colors.blue), 
                 ),
               ),
               validator: widget.validator,
             ),
           ),
         );
       }
     }