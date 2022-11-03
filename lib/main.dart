import 'dart:async';

import 'package:demo_chat/globalfunction.dart';
import 'package:flutter/material.dart';

import 'Homepage.dart';
import 'detailpage.dart';
import 'librarypage.dart';
import 'searchpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
List<String> names = ["home","library","search","person"];
int index=0;
final GlobalKey<NavigatorState> _mainnavigationkey = GlobalKey<NavigatorState>();
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
    mainnavigationkey = _mainnavigationkey;
    return MaterialApp(
      navigatorKey: _mainnavigationkey,
      home: Scaffold(
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
      ),
    );
  }
}
