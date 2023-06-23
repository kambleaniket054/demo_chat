import 'dart:async';

import 'package:demo_chat/Homepage.dart';
import 'package:demo_chat/arfilterscreen.dart';
import 'package:demo_chat/custom/ResumableState.dart';
import 'package:demo_chat/detailpage.dart';
import 'package:demo_chat/globalfunction.dart';
import 'package:demo_chat/librarypage.dart';
import 'package:demo_chat/photoeditscreen.dart';
import 'package:demo_chat/searchpage.dart';
import 'package:demo_chat/userdetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class homescreen extends StatefulWidget{
  createState()=> homescreenstate();
}
class homescreenstate extends ResumableState<homescreen> with AutomaticKeepAliveClientMixin{

  List<String> names = ["home","library","search","person"];
  int index=0;
   bool isblack = false;
  GlobalKey<NavigatorState> navigationkey = GlobalKey<NavigatorState>();
  StreamController<int> changeindexstate = StreamController<int>.broadcast();
  PageController pageController = PageController(initialPage: 0,keepPage: true);
  //StreamController<int> bottompageController = StreamController<int>.broadcast();


  @override
  void initState() {
    super.initState();
    navigationkeys = navigationkey;

    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
     // primary: true,
      body:getBottomScreen(), /*Navigator(
        key: navigationkey,
        onGenerateRoute: (RouteSettings setting){
          var page;
          switch(setting.name){
            case "home": page =  homepage();
            break;
            case "library": page= librarypage();
            break;
            case "search":page= searchpage();
            break;
            case "person": page=detailpage();
            break;
            default :
              page =  homepage();
          }
          return MaterialPageRoute(builder:(BuildContext context) =>page,settings: setting);
        },
        *//* child: Center(

            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),*//*
      )*/
      bottomNavigationBar: StreamBuilder<int>(
          stream: changeindexstate.stream,
          builder: (context, snapshot) {
            return SizedBox(
              height: 45,
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: index,
                selectedFontSize:0.0,
                unselectedFontSize: 0.0,
                backgroundColor: isblack ? Colors.black : Colors.white,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                iconSize: 24,
                items:  [
                  BottomNavigationBarItem(icon: Icon(Icons.home_outlined,color: !isblack ? Colors.black87 : Colors.white ,size: 30,),
                      activeIcon: Icon(Icons.home_filled,color: !isblack ? Colors.black87 : Colors.white ,size: 30,),
                      label: ""),
                  BottomNavigationBarItem(icon: Icon(Icons.movie_outlined,color: !isblack ? Colors.black87 : Colors.white ,size: 30,),
                      activeIcon: Icon(Icons.movie,color: !isblack ? Colors.black87 : Colors.white ,size: 30,),label: ""),
                  BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined,color: !isblack ? Colors.black87 : Colors.white ,size: 30,),
                      activeIcon: Icon(Icons.add_box,color: !isblack ? Colors.black87 : Colors.white ,size: 30,),label: ""),
                  BottomNavigationBarItem(icon: Icon(Icons.search_outlined,color: !isblack ? Colors.black87 : Colors.white ,size: 30,),
                      activeIcon: Icon(Icons.search_rounded,color: !isblack ? Colors.black87 : Colors.white ,size: 30,),label: ""),
                  BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded,color: !isblack ? Colors.black87 : Colors.white ,size: 30,),
                      activeIcon: Icon(Icons.person,color: !isblack ? Colors.black87 : Colors.white ,size: 30,),label: ""),
                ],
                onTap: (index){
                  isblack = false;
                  this.index = index;
                  if (index != 2) {
                   if(index == 1){
                    isblack = true;
                    WidgetsBinding.instance?.addPostFrameCallback((_) {
                      SystemChrome.setSystemUIOverlayStyle(
                          const SystemUiOverlayStyle(
                            statusBarColor: Colors.transparent,
                            statusBarBrightness: Brightness.dark,
                            statusBarIconBrightness: Brightness.light,
                            systemNavigationBarColor: Colors.black87,
                            systemNavigationBarDividerColor: Colors.black87,
                            systemNavigationBarIconBrightness: Brightness.light,
                          ));
                    });
                    // pushScreenname(mainnavigationkey.currentContext!,arfilterscreen());
                   }
                   else{
                     WidgetsBinding.instance?.addPostFrameCallback((_) {
                       print(_);
                       SystemChrome.setSystemUIOverlayStyle(
                         const SystemUiOverlayStyle(
                           statusBarBrightness: Brightness.dark,
                           statusBarColor: Colors.white,
                           statusBarIconBrightness: Brightness.dark,
                           systemNavigationBarColor: Colors.white,
                           systemNavigationBarDividerColor: Colors.white,
                           systemNavigationBarIconBrightness: Brightness.dark,
                         ),
                       );
                     });
                   }
                    changeindexstate.add(index);
                  }
                  else {

                    // pushScreenname(mainnavigationkey.currentContext!,arfilterscreen());
                  }
                  pageController.animateToPage(index, duration: Duration(microseconds: 1), curve: Curves.ease);
                 // navigationkey.currentState?.pushReplacementNamed(names[index]);
                },
              ),
            );
          }
      ),
     /* floatingActionButton: FloatingActionButton(
        elevation: 5,
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
        onPressed: (){},
        tooltip: 'Increment',
        child: const Icon(Icons.add,color: Colors.black,),
      ),*/ // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  getBottomScreen() {
    return PageView.builder(
      // pageSnapping: true,
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context,index) => getscreens(index));
  }

  getscreens(int index) {
    switch(index){
      case 0:
        return homepage();
      case 1:
        return librarypage();
      case 2:
        return PhotoEditingScreen();
      case 3:
        return searchpage();
      case 4:
        return userdetails();
      default :
        return  homepage();
    }
  }
}