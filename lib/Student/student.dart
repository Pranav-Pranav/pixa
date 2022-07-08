import 'package:flutter/material.dart';
import 'package:pixa/Provider/provider.dart';
import 'package:provider/provider.dart';
import 'available.dart';
import 'all.dart';
import 'issued.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'account.dart';
import 'settings.dart';

class Student extends StatefulWidget {
  GoogleSignInAccount user;
  Student({required this.user});
  @override
  State<Student> createState() => _StudentState(user:user);
}

class _StudentState extends State<Student> {
  GoogleSignInAccount user;
  _StudentState({required this.user});
  @override
  int _selectedIndex=0;

  Widget build(BuildContext context) {

    List<Widget> pages=[Home(),Settings(),Account(user: user)];
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(backgroundColor: Color(0xfff42b51),elevation: 0,title: Center(child:Text("PIXA",style: TextStyle(letterSpacing: 20,fontWeight:FontWeight.w100))),),
          body: Row(
            children: [
              NavigationRail(
                groupAlignment: .9,
                trailing: CircleAvatar(backgroundImage: NetworkImage(user.photoUrl.toString())),
                labelType: NavigationRailLabelType.all,
                selectedIndex: _selectedIndex,
                onDestinationSelected: (index){setState((){_selectedIndex = index;});},
                destinations: [
                  NavigationRailDestination(
                      icon: SizedBox.shrink(),
                      label: RotatedBox(quarterTurns: 3,child:Text("Home"))),
                  NavigationRailDestination(
                      icon: SizedBox.shrink(),
                      label: RotatedBox(quarterTurns: 3,child:Text("Settings"))),
                  NavigationRailDestination(
                      icon: SizedBox.shrink(),
                      label: RotatedBox(quarterTurns: 3,child:Text("Account")))
                ],),
              Expanded(child:pages[_selectedIndex])
            ],
          ),
        ));
    /*  Scaffold(
      body: Text("${username}"),
    )*/
  }
}



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    List<Map<String,dynamic>> dummyBoks=context.watch<BookServices>().books; //BOOKS FROM PROVIDER
    ValueNotifier dummyBoksValueNotifier = ValueNotifier(dummyBoks);

    return Column(
      children: [
        TabBar(
            indicatorColor: Color(0xfff42b51),
            labelColor: Color.fromARGB(255, 170 , 170, 200),
            tabs:[
              Tab(text:"Available"),
              Tab(text:"All"),
              Tab(text:"Issued")] ),
        SizedBox(height: MediaQuery.of(context).size.height-150,child:TabBarView(
          children: [
            ValueListenableBuilder(
                valueListenable: dummyBoksValueNotifier,
                builder: (context,dummyBoksValueNotifier,_){return Available(books: dummyBoks,email: context.watch<BookServices>().user!.email);}),
            ValueListenableBuilder(
                valueListenable: dummyBoksValueNotifier,
                builder: (context,dummyBoksValueNotifier,_){return All(books: dummyBoks,email: context.watch<BookServices>().user!.email);}),
            Issued(books:context.watch<BookServices>().books,email: context.watch<BookServices>().user!.email)
          ],
        ))
      ],
    );
  }
}
