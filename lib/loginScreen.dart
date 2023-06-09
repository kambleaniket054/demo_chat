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

class loginscreen extends StatefulWidget{
  createState() => loginscreenState();
}

class loginscreenState  extends State<loginscreen>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor:Colors.black45,
     body: Container(
       //color: Colors.red,
       child: Center(
         child: Column(
           mainAxisAlignment:MainAxisAlignment.center,
           children: [
             Container(
               padding: EdgeInsets.all(20),
               decoration: const BoxDecoration(
                 color: Colors.white,
                 shape: BoxShape.circle,
               ),
               child: createTextThemeWise("DOT", const TextStyle(
                 fontSize: 26,
                 // height: 14,
                 fontWeight: FontWeight.bold,
                 // shadows: [
                 //   Shadow(color: Colors.red,offset: Offset(1, 1),blurRadius: 5),
                 // ],
                 fontStyle: FontStyle.italic,
                 color: Colors.black,
                 // decorationColor: Colors.black38,
               )),
             ),
            Card(
              margin: EdgeInsets.only(left: 20,right: 20,top: 40),
              color: Colors.grey.withOpacity(0.3),
              elevation: 5,
              borderOnForeground: true,
              shadowColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 40,top: 40,),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: const TextField(

                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            color: Colors.grey
                        ),
                        decoration: InputDecoration(
                          hintText: "UserName",
                          hintStyle: TextStyle(color: Colors.grey),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          fillColor: Colors.red,
                         // border: InputBorder.none
                      //       enabledBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(color: Colors.black38),
                      // ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                     Container(
                       decoration: BoxDecoration(
                         color: Colors.white.withOpacity(0.3),
                         borderRadius: BorderRadius.circular(10),
                       ),
                       // margin: EdgeInsets.only(left: 15,right: 10,top: 10),
                       padding: EdgeInsets.only(left: 10,right: 10),
                       child:  TextField(
                         keyboardType: TextInputType.text,
                         style:const TextStyle(
                           color: Colors.grey
                         ),
                         decoration:const InputDecoration(
                             hintText: "password",
                             hintStyle: TextStyle(color: Colors.grey),
                           floatingLabelBehavior: FloatingLabelBehavior.never,
                           fillColor: Colors.red,
                           // enabledBorder: OutlineInputBorder(
                           //   borderSide: BorderSide(color: Colors.black38),
                           // ),
                         ),
                       ),
                     ),
                     SizedBox(height: 50,),
                     InkWell(
                       onTap: (){
                         Navigator.pushReplacement(mainnavigationkey.currentContext!,MaterialPageRoute (builder: (BuildContext context) =>  homescreen()));
                       },
                       child: Container(
                         width: MediaQuery.of(context).size.width,
                         decoration: BoxDecoration(
                           color: Colors.white.withOpacity(0.4),
                           borderRadius: BorderRadius.circular(10),
                         ),
                         margin: const EdgeInsets.only(left: 20,right: 20,top: 10),
                         padding: const EdgeInsets.only(top: 20,bottom: 20),
                         child:const Text("Login",textAlign: TextAlign.center,style: TextStyle(
                           color: Colors.white,
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
                     var ref = FirebaseDatabase.instance.reference().child("Userdetails");
                     // print(data.additionalUserInfo.profile);
                     await ref.set({
                       data.user.uid : {'username':data.user.displayName,
                       'creationdate' : data.user.metadata.creationTime.toString(),
                         'photourl': data.user.photoURL,
                       },
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
                 width: 150,
                 height: 50,
                 decoration: BoxDecoration(
                   color: Colors.white.withOpacity(0.6),
                   borderRadius: BorderRadius.circular(10),
                 ),
                 margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                 padding: EdgeInsets.only(left: 10,right: 10),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     SvgPicture.asset("assets/google.svg",width: 20,height: 40,fit: BoxFit.contain,),
                     /*Text("oogle",style: TextStyle(
                       color: Colors.white,
                       fontSize: 18
                     ),),*/
                   ],
                 ),
               ),
             ),
           ],
         ),
       ),
     ),
   );
  }

}