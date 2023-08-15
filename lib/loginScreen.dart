/*
import 'dart:math';
import 'dart:ui';

import 'package:demo_chat/Homescreen.dart';
import 'package:demo_chat/globalfunction.dart';
import 'package:demo_chat/userdetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class loginscreen extends StatefulWidget{
  createState() => loginscreenState();
}

class loginscreenState  extends State<loginscreen>{


  TextEditingController _conusername = TextEditingController();
  TextEditingController _conpswd = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   checksigin();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor:const Color(0XffFCFCFC),
     body: Container(
       // color: Colors.black.withOpacity(0.3),
       width: MediaQuery.of(context).size.width,
       height: MediaQuery.of(context).size.height,
       child: Center(
         child: Column(
           mainAxisAlignment:MainAxisAlignment.center,
           children: [
             Container(
               padding: const EdgeInsets.all(10),
               decoration: const BoxDecoration(
                 color: Color(0XFFFCFCFC),
                 shape: BoxShape.circle,
                 boxShadow: [
                   // BoxShadow(color: Colors.black38,
                   //   offset: Offset(4,2),
                   //   blurRadius: 3,
                   //   // inset:true,
                   // ),
                   // BoxShadow(color: Colors.white70,
                   //     offset: Offset(-5,-2),
                   //     blurRadius: 2
                   // ),
                 ],
               ),
               child: Container(
                 padding: EdgeInsets.all(30),
                 decoration: const BoxDecoration(
                   color: Colors.black,
                   shape: BoxShape.circle,
                   border: Border.fromBorderSide(BorderSide(color: Colors.black)),
                   // boxShadow: [
                   //   BoxShadow(color: Colors.black38,
                   //     offset: Offset(4,2),
                   //     blurRadius: 3,
                   //     // inset:true,
                   //   ),
                   //   BoxShadow(color: Colors.white70,
                   //       offset: Offset(-5,-2),
                   //       blurRadius: 2
                   //   ),
                   // ],
                 ),
                 child: createTextThemeWise("DOT", const TextStyle(
                   fontSize: 26,
                   // backgroundColor: Colors.white,
                   // height: 14,
                   fontWeight: FontWeight.bold,
                   // shadows: [
                   //   Shadow(color: Colors.red,offset: Offset(1, 1),blurRadius: 5),
                   // ],
                   fontStyle: FontStyle.italic,
                   color: Colors.white,
                   // decorationColor: Colors.black38,
                 )),
               ),
             ),
            Card(
              margin: EdgeInsets.only(left: 20,right: 20,top: 40),
              color: Color(0XFFFCFCFC),
              elevation: 0,
              borderOnForeground: true,
              // shadowColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 40,top: 40,),
                child: Column(
                  children: [
                    Container(
                      // decoration: BoxDecoration(
                      //   color: Colors.white.withOpacity(0.3),
                      //   borderRadius: BorderRadius.circular(10),
                      // ),
                      // margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child:  TextField(
                        controller: _conusername,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            color: Colors.grey
                        ),
                        decoration: InputDecoration(
                          hintText: "UserName",
                          hintStyle: TextStyle(color: Color(0Xff9d9fA0),fontSize: 12),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border:UnderlineInputBorder(
                            borderSide: const BorderSide(color:  Color(0Xff9d9fA0)),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                     Container(
                       // decoration: BoxDecoration(
                       //   color: Colors.white.withOpacity(0.3),
                       //   borderRadius: BorderRadius.circular(10),
                       // ),
                       // margin: EdgeInsets.only(left: 15,right: 10,top: 10),
                       padding: EdgeInsets.only(left: 10,right: 10),
                       child:  TextField(
                         controller: _conpswd,
                         cursorColor: Colors.black87,
                         keyboardType: TextInputType.text,
                         style: const TextStyle(
                           color: Colors.grey,
                         ),
                         decoration: InputDecoration(
                             hintText: "password",
                             hintStyle: const TextStyle(color:  Color(0Xff9d9fA0),fontSize: 12),
                           floatingLabelBehavior: FloatingLabelBehavior.never,
                           // filled: true,
                           // fillColor: Colors.grey,
                           border:UnderlineInputBorder(
                             borderSide: BorderSide(color:  Color(0Xff9d9fA0)),
                             borderRadius: BorderRadius.circular(5.0),
                           ),
                           // enabledBorder: OutlineInputBorder(
                           //   borderSide: BorderSide(color: Colors.black38),
                           // ),
                         ),
                       ),
                     ),
                     const SizedBox(height: 50,),
                     InkWell(
                       onTap: ()async{
                         try {
                           final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                               email:_conusername.text,
                               password: _conpswd.text,
                           );
                           if(credential ==null){
                             return;
                           }
                            usredetails = credential.user;

                           var ref = FirebaseDatabase.instance.reference().child("Userdetails").child(usredetails.uid);
                           // userdetails = credential.user;
                           await ref.update({
                             'username':usredetails.displayName,
                             'creationdate' : usredetails.metadata.creationTime.toString(),
                             'photourl': usredetails.photoURL,
                             'followers':0,
                             'following':0,
                             'email':usredetails.email,
                             "phonenumber":usredetails.phoneNumber
                           },);
                           Navigator.pushReplacement(mainnavigationkey.currentContext!,MaterialPageRoute (builder: (BuildContext context) =>  homescreen()));
                         } on FirebaseAuthException catch (e) {
                           if (e.code == 'user-not-found') {
                             print('No user found for that email.');
                           } else if (e.code == 'wrong-password') {
                             print('Wrong password provided for that user.');
                           }
                         }
                         // Navigator.pushReplacement(mainnavigationkey.currentContext!,MaterialPageRoute (builder: (BuildContext context) =>  homescreen()));
                       },
                       child: Container(
                         width: MediaQuery.of(context).size.width,
                         decoration: BoxDecoration(
                           color: Color(0XFFFCFCFC),
                           borderRadius: BorderRadius.circular(8),
                           border: Border.all(color: Colors.grey),
                           boxShadow: [
                             BoxShadow(
                               color: Colors.black38,
                               offset: Offset(3,3),
                               spreadRadius: 2,
                               blurRadius: 2
                             )
                           ],
                         ),
                         margin: const EdgeInsets.only(left: 20,right: 20,top: 10),
                         padding: const EdgeInsets.only(top: 20,bottom: 20),
                         child:const Text("Login",textAlign: TextAlign.center,style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 16,
                           color: Colors.black87,
                         ),),
                       ),
                     ),
                  ],
                ),
              ),
            ),
             const SizedBox(height: 25,),
             const Divider(height: 1.0,endIndent: 3,indent: 3,),
             const SizedBox(height: 25,),
             InkWell(
               onTap: ()async {
                 try {
                  bool id = await GoogleSignIn().isSignedIn();
                  if(id){
                    await GoogleSignIn().signOut();
                  }
                   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

                   // Obtain the auth details from the request
                   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

                   // Create a new credential
                   final credential = GoogleAuthProvider.credential(
                     accessToken: googleAuth?.accessToken,
                     idToken: googleAuth?.idToken,
                   );

                   if (credential != null) {
                     var data =  await FirebaseAuth.instance.signInWithCredential(credential);
                     // print(data.additionalUserInfo.profile);
                     var ref = FirebaseDatabase.instance.reference().child("Userdetails").child(data.user.uid);
                     // print(data.additionalUserInfo.profile);
                     await ref.update({
                       'username':data.user.displayName,
                       'creationdate' : data.user.metadata.creationTime.toString(),
                         'photourl': data.user.photoURL,
                         'followers':0,
                         'following':0,
                         'email':data.user.email,
                         "phonenumber":data.user.phoneNumber
                     },);
                     Navigator.pushReplacement(mainnavigationkey.currentContext!,MaterialPageRoute (builder: (BuildContext context) =>  homescreen()));
                   }
                 } catch (e) {
                  print(e.toString());
                 }

                 // Once signed in, return the UserCredential

                 // ref.child('users').set(data);
               },
               child: Container(
                 // width: 150,
                 // height: 50,
                 decoration: BoxDecoration(
                   color: Colors.white,
                   border: Border.all(color: Colors.grey),
                   boxShadow: [
                     BoxShadow(
                         color: Colors.black38,
                         offset: Offset(0,0),
                         spreadRadius: 0,
                         blurRadius: 1
                     )
                   ],
                   borderRadius: BorderRadius.circular(60),
                 ),
                 // margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                 // padding: EdgeInsets.only(left: 10,right: 10),
                 child: SvgPicture.asset("assets/google.svg",width: 20,height: 40,fit: BoxFit.fill),
               ),
             ),
           ],
         ),
       ),
     ),
   );
  }

  void checksigin()async {
    bool id = await GoogleSignIn().isSignedIn();
   userdata = GoogleSignIn().currentUser;
    if(id){
      Navigator.pushReplacement(mainnavigationkey.currentContext!,MaterialPageRoute (builder: (BuildContext context) =>  homescreen()));
    }
  }

}
*/
import 'package:demo_chat/userdetails.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

import 'package:demo_chat/Homescreen.dart';
import 'package:demo_chat/globalfunction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'Homescreen.dart';
import 'globalfunction.dart';

class loginscreen extends StatelessWidget {
  // LoginPage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  Future<void> signUserIn() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email:usernameController.text,
        password: passwordController.text,
      );
      if(credential ==null){
        return;
      }
      usredetails = credential.user;
      Navigator.pushReplacement(mainnavigationkey.currentContext!,MaterialPageRoute (builder: (BuildContext context) =>  homescreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // logo
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration:  BoxDecoration(
                    border: Border.all(color: Colors.white),
                    // borderRadius: BorderRadius.circular(16),
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                    // color: Color(0XFFFCFCFC),
                    // shape: BoxShape.circle,
                    // boxShadow: [
                    //   // BoxShadow(color: Colors.black38,
                    //   //   offset: Offset(4,2),
                    //   //   blurRadius: 3,
                    //   //   // inset:true,
                    //   // ),
                    //   // BoxShadow(color: Colors.white70,
                    //   //     offset: Offset(-5,-2),
                    //   //     blurRadius: 2
                    //   // ),
                    // ],
                  ),
                  child: Container(
                    padding: EdgeInsets.all(30),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                      border: Border.fromBorderSide(BorderSide(color: Colors.black)),
                      // boxShadow: [
                      //   BoxShadow(color: Colors.black38,
                      //     offset: Offset(4,2),
                      //     blurRadius: 3,
                      //     // inset:true,
                      //   ),
                      //   BoxShadow(color: Colors.white70,
                      //       offset: Offset(-5,-2),
                      //       blurRadius: 2
                      //   ),
                      // ],
                    ),
                    child: createTextThemeWise("DOT", const TextStyle(
                      fontSize: 26,
                      // backgroundColor: Colors.white,
                      // height: 14,
                      fontWeight: FontWeight.bold,
                      // shadows: [
                      //   Shadow(color: Colors.red,offset: Offset(1, 1),blurRadius: 5),
                      // ],
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      // decorationColor: Colors.black38,
                    )),
                  ),
                ),
               /* Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white
                  ),
                  padding: EdgeInsets.all(20),
                  child: const Icon(
                    Icons.person,
                    size: 100,
                  ),
                ),*/

                const SizedBox(height: 50),

                // welcome back, you've been missed!
               /* Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),*/

                // const SizedBox(height: 25),

                // username textfield
                MyTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // sign in button
                MyButton(
                  onTap: signUserIn,
                ),

                const SizedBox(height: 50),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    // google button
                    SquareTile(imagePath: 'assets/google.png'),

                    const SizedBox(width: 25),

                    // apple button
                    SquareTile(imagePath: 'assets/apple.png')
                  ],
                ),

                const SizedBox(height: 50),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Register now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  
  
  
}

SquareTile({required String imagePath}) {
  return Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
      // borderRadius: BorderRadius.circular(16),
      shape: BoxShape.circle,
      color: Colors.grey[200],
    ),
    child: Image.asset(
      imagePath,
      height: 40,
    ),
  );
}

MyTextField({required TextEditingController controller, required String hintText, required bool obscureText}) {
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

Widget MyButton({void Function()? onTap}) {
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
          "Sign In",
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