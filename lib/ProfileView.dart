import 'dart:convert';

import 'package:demo_chat/Colorcode.dart';
import 'package:demo_chat/MessageBloc/cubitstate.dart';
import 'package:demo_chat/Vm/vm_post.dart';
import 'package:demo_chat/loginScreen.dart';
import 'package:demo_chat/profileBloc/ProfileCubit.dart';
import 'package:demo_chat/profileBloc/cubitState.dart';
import 'package:demo_chat/profileBloc/porfilecontroller.dart';
import 'package:demo_chat/profileBloc/profileState.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'Model/instaPostmodel.dart';
import 'Model/commentModel.dart' as cm;
import 'Model/profileDetailModel.dart';
import 'globalfunction.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'profileBloc/profileEvent.dart';
// import 'profileBloc/profileState.dart';

class profileView extends StatefulWidget {
  bool isuser = true;
  cm.Owner userInfo;
  String fromScreen;
  profileView({this.isuser, this.userInfo, this.fromScreen});
  @override
  State<StatefulWidget> createState() {
    return profileViewstate();
  }
}

class profileViewstate extends State<profileView> {
  bool iscall = false;
  bool isUser = true;
  String fromscreen = "";
  cm.Owner userinfo;
  bool isfollowing = false;
  bool isfollower = false;
  List<dynamic> templist = [];
  profilecontroller profilec = profilecontroller();
  vm_post _vm_post = vm_post();
  final pCubit = ProfileCubit();
  @override
  void initState() {
    templist = [];
    // TODO: implement initState
    super.initState();
    isUser = widget.isuser;
    fromscreen = widget.fromScreen;
    userinfo = widget.userInfo;
    if (userinfo != null && userinfo?.id != null) {
      profilec
          .add(fecthprofiledetails(uid: userinfo?.id ?? "", isFirebase: false));
      pCubit.fetchprofilePost(userinfo?.id ?? "", isfirebase: false);
    } else {
      profilec
          .add(fecthprofiledetails(uid: Usersprofile.uid, isFirebase: true));
      pCubit.fetchprofilePost(Usersprofile.uid, isfirebase: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<profilecontroller, profileState>(
      bloc: profilec,
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object state) {
        var profileInfo;
        ProfileDetailModel profileinfoo = ProfileDetailModel();
        if (state.runtimeType == profileDateReceived) {
          profileInfo = state as profileDateReceived;
          profileinfoo = profileInfo.profileDetails;
          isfollowing = profileInfo.isfollowing;
          isfollower = profileInfo.isfollower;
        }
        else if(state.runtimeType == profileErrorresponse){
          return Center(
            child: Container(
              child: createTextThemeWise("No user Found", style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              )),
            ),
          );
        }

        // profileDateReceived = state;
        // ProfileDetailModel profiledetail = state;
        print(state);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: isUser == true
              ? AppBar(
                  systemOverlayStyle: const SystemUiOverlayStyle(
                    systemNavigationBarColor: Colors.black,
                    systemNavigationBarIconBrightness: Brightness.light,
                  ),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  brightness: Brightness.dark,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  leadingWidth: 0.0,
                  centerTitle: false,
                  title: const Text("Details",
                      style: TextStyle(
                        color: Color.fromARGB(255,40, 40, 43),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      textScaleFactor: 1.0),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: createTextThemeWise("Edit",
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255,40, 40, 43),)),
                    ),
                   /* IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          FirebaseAuth.instance.signOut();
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      loginscreen()),
                                              (route) => false);
                                        },
                                        child: Row(
                                          children: [
                                            createTextThemeWise(
                                              "Logount",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                        icon: const Icon(Icons.menu)),*/
                    TextButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      loginscreen()),
                                  (route) => false);
                        },
                        child:Text("Logout",style: TextStyle(color: Colors.blue),)/* const Icon(Icons.logout_rounded)*/),
                  ],
                )
              : AppBar(
                  systemOverlayStyle: const SystemUiOverlayStyle(
                    systemNavigationBarColor: Color.fromARGB(255,40, 40, 43),
                    systemNavigationBarIconBrightness: Brightness.light,
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0.5,
                  foregroundColor:Color.fromARGB(255,40, 40, 43),
                  brightness: Brightness.dark,
                  automaticallyImplyLeading: true,
                  leadingWidth: 24,
                  centerTitle: false,
                  title: const Text(
                    "Details",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    textScaleFactor: 1.0,
                  ),
                  // actions: [
                  //   IconButton(
                  //       onPressed: () {},
                  //       icon: const Icon(Icons.add_circle_outline)),
                  //   IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
                  // ],
                ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 10, 8, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // SizedBox(width: 10,),
                    Container(
                      margin: const EdgeInsets.only(left: 0, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        //color:color.elementAt(index),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: CircleAvatar(
                        backgroundColor: Colors.orange,
                        radius: 48,
                        backgroundImage: const NetworkImage(
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Windows_10_Default_Profile_Picture.svg/2048px-Windows_10_Default_Profile_Picture.svg.png"),
                        foregroundImage: NetworkImage(profileinfoo.photourl ??
                            ""), /*AssetImage("assets/ArcticFox.gif")*/
                      ),
                    ),
                    // CircleAvatar(
                    //   child: Image.network("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAHwAAAB8CAMAAACcwCSMAAAAMFBMVEXk5ueutLersbTP09Xn6eqxt7rh4+S2u77Y29zV2Nq8wcTJzc/d4OG5vsHCx8nFysx2ylK/AAACtklEQVRoge2aSZLDIAxFGQTY4OH+t208tJPOAJIjuatS/E1S3jwLhIAvK9XU1NTU1NTU1NTU9L0C+Pt7JdnbOY4hhHFK3aUvACoFY4zelP9FexUehniA9fECSV2ABzU9oVe8tuJ06Nwr9IqP0mz7Dr3Q3SDKTgX2ok5u6GGusLURo1fjXuhCIw99na21k4ErBDqHPkkMPERM4Jne89Ohw7FlBj4g2dok7tBx2baH7rnhI5qtDXeVR8/4osALx9SXO/FWGnAUNnPKDRS21iMrnJDra+iccOKU824v2NJ6wDtOOLq87XDOlU5LduZ0BxqbGU6bcm3mr4mcmnCscMKetsI5TzMw/ec6L11UXsEZ2Xk7J7G1493QaYHzHp8hkuA9J5u6p/KylSdUd/ZLS/2CeifOhbaKcJDiPUQtwtcZkVsyli1xTUVXOX60wh7kuNf4IcRyYz1G/FE9402Us6P8P7Jz7G/9x5Ut4sfc5Mf3dGNF0Wq5OenXeOME7ceD7p8d783zvkQwPLjexrhL7PYdr2x0ZpcOc3dtoyXT/NBba/vBXxf0Rl5wftftyQVc39kpjsGtrZ089y6EOKXey3a5MrhL21w/J3t+Ns69EB9gSOML7MMrOIHky2T3prg8voDm5YPqI478yw/W8+Dzmg5Eb2CptYkDD7a4kRXC/7joFXp4dfxnntSyh5xFr/hwfqM7O+L3ms/CiXbEm+CHE8GD/zzsDU/3Z/DNpDqdak1RTZgynXauZGUT6ZQ+Fjedcb4POnrea/eSU3RszhONVqRQlgHJfSEI1ekjmo1oYaad6m4TVO/vcq+ym+rrjdpTINFrbLnAEaGTDF6yymwvGHit18e8oTypaNnQbHW6yl9TENuWVBUbP4PsqJcnXXKhrfCCPwnJCKtkxXdWWqWEu/wD2qampqYv1Q/CWR25WJskOAAAAABJRU5ErkJggg=="),
                    // ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children:  [
                        Text(
                          "Posts",
                          style: TextStyle(
                            color: Colorcode.mattBlack,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                       const SizedBox(
                          height: 8,
                        ),
                        Text("401"),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: const [
                        Text(
                          "Followers",
                          style: TextStyle(
                            color: Color.fromARGB(255,40, 40, 43),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text("14,003"),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children:  [
                        Text(
                          "Following",
                          style: TextStyle(
                            color:Colorcode.mattBlack,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      const  SizedBox(
                          height: 8,
                        ),
                        Text("14,003"),
                      ],
                    ),
                    // SizedBox(width: 10,),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profileinfoo.username.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      profileinfoo.email.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 54),
                child: const Text(
                  "You can write a bio of up to 150 characters on your Instagram profile. Please keep in mind that anyone can see your bio. Tap your profile picture in the bottom right to go to your profile. Tap Edit profile at the top of the screen, then tap the text box below Bio",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Visibility(
                visible: !isUser,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () async {
                                var ref = FirebaseDatabase.instance
                                    .reference()
                                    .child("Userdetails")
                                    .child(Usersprofile.uid+"/following");
                                // var hasuser = await ref.once().;
                                await ref.push().set(userinfo?.id);

                                // await ref.push.({
                                //   'followers':0,
                                // },);
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 12, right: 12, top: 8, bottom: 8),
                                decoration: BoxDecoration(
                                  color: isfollowing ? Colors.blue : Colorcode.backgroundcolor
                                      .withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: createTextThemeWise( isfollowing ? "Following" : "Follow",
                                    style:  TextStyle(
                                      fontSize: 14,
                                      color: isfollowing ? Colors.white : Colors.black87,
                                    )),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 8, bottom: 8),
                              decoration: BoxDecoration(
                                color:
                                    Colorcode.backgroundcolor.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: createTextThemeWise("Message",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  )),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 8, bottom: 8),
                              decoration: BoxDecoration(
                                color:
                                    Colorcode.backgroundcolor.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: createTextThemeWise("Email",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: DefaultTabController(
                  initialIndex: 0,
                  length: 2,
                  child: Container(
                    // height: MediaQuery.of(context).size.height/2*7,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const TabBar(
                          tabs: [
                            Tab(
                              icon: Icon(
                                Icons.photo_rounded,
                                color: Color.fromARGB(255,40, 40, 43),
                              ),
                              iconMargin: EdgeInsets.only(bottom: 0),
                            ),
                            Tab(
                              icon: Icon(
                                Icons.video_camera_back_rounded,
                                color: Color.fromARGB(255,40, 40, 43),
                              ),
                              iconMargin: EdgeInsets.only(bottom: 0),
                            ),
                            // Tab(icon: Icon(Icons.tag,color: Colors.black38,),iconMargin: EdgeInsets.only(bottom: 0),),
                          ],
                          indicatorSize: TabBarIndicatorSize.tab,

                          indicatorColor: Colors.black38,
                          indicatorPadding: EdgeInsets.only(top: 2, bottom: 5),
                          unselectedLabelColor: Colors.grey,
                        ),
                        Flexible(
                          child: TabBarView(children: [
                            StreamBuilder<profilecubitState>(
                                stream: pCubit.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                          ConnectionState.waiting &&
                                      templist.length == 0 &&
                                      !iscall) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (snapshot.connectionState ==
                                          ConnectionState.active &&
                                      snapshot.data.runtimeType ==
                                          profilePostError) {
                                    iscall = true;
                                    return const Center(
                                      child: Text("No Data At Moment"),
                                    );
                                  }

                                  var userPostlist;
                                  // List<dynamic> templist = [];
                                  if (snapshot.data != null) {
                                    userPostlist = snapshot.data
                                        as profilePostDatatReceived;
                                    templist = userPostlist.postList;
                                    iscall = true;
                                  }

                                  return Container(
                                    color: Colors.white,
                                    child: GridView.builder(
                                        addAutomaticKeepAlives: true,
                                        addRepaintBoundaries: true,
                                        cacheExtent: 9999,
                                        itemCount: templist.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          mainAxisSpacing: 4,
                                          crossAxisSpacing: 4,
                                          childAspectRatio: 0.9,
                                        ),
                                        itemBuilder: (context, index) {
                                          Datum data;
                                          data = templist[index];
                                          return FittedBox(
                                            fit: BoxFit.fill,
                                            child: data.isfirebase == true
                                                ? Image.memory(
                                                    base64Decode(data.image))
                                                : Image.network(
                                                    data.image,
                                                    errorBuilder:
                                                        (context, obj, track) {
                                                      return FittedBox(
                                                          fit: BoxFit.fill,
                                                          child: Container(
                                                            color: Colors.grey,
                                                          ));
                                                    },
                                                  ),
                                          ) /* CachedNetworkImage(

                                       imageUrl: data.image,
                                       fit: BoxFit.cover,
                                       placeholder: (context,snapshot){
                                         return  Center(child: CircularProgressIndicator(value: double.parse(snapshot.length.toString()),color: Colors.black38,backgroundColor: Colors.white54,));
                                       },
                                       // progressIndicatorBuilder: (context, url, downloadProgress) =>
                                       //     Center(child: CircularProgressIndicator(value: downloadProgress.progress,color: Colors.black38,backgroundColor: Colors.white54,)),
                                       errorWidget: (context, url, error) =>  Icon(Icons.error),
                                     )*/
                                              ;
                                        }),
                                  );
                                }),
                            Container(
                              child: Center(
                                child: createTextThemeWise("No Video Uploaded",
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.grey)),
                              ),
                            ),
                            // Container(),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
