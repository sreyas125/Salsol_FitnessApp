import 'package:flutter/material.dart';

class Custompassword extends StatefulWidget {
  final String texthint;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final IconData icon;

   const Custompassword({
    super.key,
    required this.texthint,
    required this.controller,
    required this.validator,
    required this.icon,
    });

  @override
  State<Custompassword> createState() => _CustompasswordState();
}

class _CustompasswordState extends State<Custompassword> {
  final ValueNotifier<bool> _showPassword = ValueNotifier<bool>(false);
 
   @override
   void dispose() {
    _showPassword.dispose();
   super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
              //width: 420,
               child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child:ValueListenableBuilder(valueListenable: _showPassword,
                   builder: (context, value, child) { 
                  return TextFormField(
                    obscureText: !_showPassword.value,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: widget.controller,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: widget.texthint,
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: IconButton(
                        onPressed: (){
                          _showPassword.value = !_showPassword.value;
                      }, icon: Icon(widget.icon),
                      ),
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
             );
            })
           ),
         );
  }
}