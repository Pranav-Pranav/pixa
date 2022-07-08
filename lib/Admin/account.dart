import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pixa/Provider/provider.dart';
import 'package:provider/provider.dart';

class Account extends StatefulWidget {
  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 100,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(radius: MediaQuery.of(context).size.width/5,backgroundImage: AssetImage('assets/asmin.png')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${"Admin"}",style: TextStyle(fontSize: 30)),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(height: 60,width: MediaQuery.of(context).size.width/2,child:ElevatedButton(child: Text("Sign Out"),style: ElevatedButton.styleFrom(primary: Color(0xfff42b51),shape:  StadiumBorder()),onPressed: ()async{context.read<BookServices>().adminSignout();})),
            )
          ],
        ),
      ),
    );
  }
}
