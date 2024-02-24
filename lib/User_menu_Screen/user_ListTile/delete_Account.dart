import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  bool agreed = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    Color buttonColor = agreed ? Colors.black : const Color.fromARGB(255, 180, 178, 178);
    Color textColor = agreed ? Colors.white : const Color.fromARGB(255, 112, 108, 108);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: BackButton(),
        centerTitle: true,
        title: const Text('Delete Account'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30, left: 20),
            child: Text(
              'Are You Sure You Want to Delete Your Account?',
              style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 52, 51, 51)),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'If you delete your account:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(CupertinoIcons.link),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Text(
                  '''You'll lose all data in associated salsol app accounts using the same email address and phone number.''',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(CupertinoIcons.person_2),
              ),
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "You won't be able to access salsol member benefits",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.phone_android_outlined),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "You'll be disconnected from salsol fitness app.",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Once you delete your account, you'll be logged out of this app. If you're logged into this salsol app, it could take up to 1 hour for your session to expire.",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'If you change your mind, you can always come back and open a new account with us.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Are you sure you want to delete your account? (This can't be undone)",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              StatefulBuilder(
                builder: (context, setState) {
                  return Checkbox(
                    activeColor: Colors.black,
                    value: agreed,
                    onChanged: (value) {
                      setState(() {
                        agreed = value!;
                        buttonColor = agreed ? Colors.black : const Color.fromARGB(255, 180, 178, 178);
                        textColor = agreed ? Colors.white : const Color.fromARGB(255, 112, 108, 108);
                      });
                    },
                  );
                },
              ),
              Text(
                'Yes, I want to delete my account.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 73, 71, 71),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          ElevatedButton(
            onPressed: agreed
                ? () {
                    
                  }
                : null,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              backgroundColor: buttonColor,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.25, vertical: 18),
              child: Text(
                'Delete Account',
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ),
           SizedBox(height: 20,),
          ElevatedButton(
            onPressed:(){
             Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black,width: 0.4,),
                borderRadius: BorderRadius.circular(25.0),
              ),
              backgroundColor: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.33, vertical: 18),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Color.fromARGB(255, 47, 45, 45),
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
