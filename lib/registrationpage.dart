import 'package:demo_chat/globalfunction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';


class Registrationpage extends StatefulWidget{
  createState() => registerState();
}

class registerState extends State{
  TextEditingController usernameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController CpassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        automaticallyImplyLeading: true,
        centerTitle: false,
        title: const Text("Registration"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 25),
            MyTextField(
              controller: usernameController,
              hintText: 'Username',
              obscureText: false,
            ),
            const SizedBox(height: 25),
            MyTextField(
              controller: EmailController,
              hintText: 'Email',
              obscureText: false,
            ),
            const SizedBox(height: 25),
            MyTextField(
              controller: phoneController,
              hintText: 'PhoneNumber',
              obscureText: false,
            ),
            const SizedBox(height: 25),
            MyTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),
            const SizedBox(height: 25),
            MyTextField(
              controller: CpassController,
              hintText: 'Confirm Password',
              obscureText: true,
            ),
            const SizedBox(height: 25),
            MyButton(
              onTap: () async {
                if(passwordController.text.trim() != CpassController.text.trim()){
                  CpassController.clear();
                  showDialog(context: context, builder: (context){
                    return Container(
                      padding: const EdgeInsets.only(top: 15,bottom: 15,right: 25,left: 25),
                      child: const Text("Password and Confirm password is Not save"),
                    );
                  });
                  Future.delayed(Duration(microseconds: 30),(){
                    Navigator.pop(context);
                  });
                }
                final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email:EmailController.text.trim(),
                  password: passwordController.text,
                ).onError((error, stackTrace){
                  print(error.toString());
                  throw error.toString();
                });
                if(credential == null){
                  return;
                }
                Usersprofile = credential.user;
                // SharedPreferences sharedPreference = await SharedPreferences.getInstance();
                // sharedPreference.setString("user", Usersprofile.uid.toString());


                var ref = FirebaseDatabase.instance.reference().child("Userdetails").child(Usersprofile.uid);
                // print(data.additionalUserInfo.profile);\

                // if(Usersprofile.uid == )
                // var haschild = FirebaseDatabase.instance.reference().child("Userdetails").orderByChild(data.user?.uid).once().then((value) => value);
                await ref.update({
                  'username':usernameController.text,
                  'creationdate' : DateTime.now().toString(),
                  'photourl': "",
                  'followers':[],
                  'following':[],
                  'email':EmailController.text.trim(),
                  "phonenumber":phoneController.text
                },);
              }
            ),
          ],
        ),
      ),
    );
  }




  MyTextField({ TextEditingController controller,  String hintText,  bool obscureText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500])),
      ),
    );
  }

  Widget MyButton({void Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            "Sign Up",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

