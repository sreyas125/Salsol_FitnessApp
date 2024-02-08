import 'package:flutter/material.dart';

class UserEditScreen extends StatefulWidget {
  final String userEmail;
  const UserEditScreen({
    super.key,
     required this.userEmail});

  @override
  State<UserEditScreen> createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('User Edit'),
        backgroundColor: Colors.grey,
        leading: const BackButton(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100,left: 90),
                child: Center(
                  child: Text('Your Current account email address is:\n ${widget.userEmail}',
                  style: const TextStyle(fontSize: 1,
                  fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
       const SizedBox(height: 20,),
        TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: 'Current Email',
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
      ],
    ),
  );
 }
}