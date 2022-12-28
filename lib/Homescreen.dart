import 'dart:async';

import 'package:demo_chat/Homepage.dart';
import 'package:demo_chat/detailpage.dart';
import 'package:demo_chat/globalfunction.dart';
import 'package:demo_chat/librarypage.dart';
import 'package:demo_chat/searchpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class homescreen extends StatefulWidget{
  createState()=> homescreenstate();
}
class homescreenstate extends State<homescreen>{

  List<String> names = ["home","library","search","person"];
  int index=0;

  GlobalKey<NavigatorState> navigationkey = GlobalKey<NavigatorState>();
  StreamController<bool> changeindexstate = StreamController<bool>.broadcast();


  @override
  void initState() {
    super.initState();
    navigationkeys = navigationkey;

    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      body: Navigator(
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
        /* child: Center(

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
          ),*/
      ),
      bottomNavigationBar: StreamBuilder<bool>(
          stream: changeindexstate.stream,
          builder: (context, snapshot) {
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: index,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home_outlined,color: Colors.black54,),
                    activeIcon: Icon(Icons.home_filled,color: Colors.black54,),
                    label: ""),
                BottomNavigationBarItem(icon: Icon(Icons.my_library_add_outlined,color: Colors.black54,),
                    activeIcon: Icon(Icons.my_library_add,color: Colors.black54,),label: ""),
                BottomNavigationBarItem(icon: Icon(Icons.search_outlined,color: Colors.black54,),
                    activeIcon: Icon(Icons.search_rounded,color: Colors.black54,),label: ""),
                BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded,color: Colors.black54,),
                    activeIcon: Icon(Icons.person,color: Colors.black54,),label: ""),
              ],
              onTap: (index){
                this.index = index;
                changeindexstate.add(true);
                navigationkey.currentState?.pushReplacementNamed(names[index]);
              },
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}