import 'package:flutter/material.dart';
import 'package:pixa/Admin/admin.dart';
import 'package:provider/provider.dart';
import '/Provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '/Student/student.dart';
import '/Admin/admin.dart';
import 'decision.dart';


class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  GoogleSignIn _googleSignIn=GoogleSignIn(scopes: ['email']);
  @override
  Widget build(BuildContext context) {
    TextEditingController email=TextEditingController();
    TextEditingController password=TextEditingController();
    int _admin=context.watch<BookServices>().admin;
    GoogleSignInAccount? _user=context.watch<BookServices>().user;
    return (_user!=null||_admin!=0)?(_user!=null)?Student(user: _user):Admin(): Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width/1.25,
                  child: TextField(
                    controller: email,
                      decoration: InputDecoration(
                          labelText: 'username*',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width/1.25,
                  child: TextField(
                    controller: password,
                      decoration: InputDecoration(
                          labelText: 'password*',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))),
                      obscureText: true
                  )
              ),
            ),
            //ElevatedButton(onPressed: (){context.read<BookServices>().changeTheme();}, child: Text("Change Theme")),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width/1.25,
                  child:ElevatedButton(
                      child: Text("Sign In for Admin"),
                      style: ElevatedButton.styleFrom(primary: Colors.black,shape:  StadiumBorder()),
                      onPressed: ()async{
                        email.text=="SUTT_admin"&&password.text=="1234567890"?context.read<BookServices>().adminSignin():print("");})),
            ),
            SizedBox(height: 10,),
            Text(_user==null ? "Or":_user.email,style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width/1.25,
                  child:ElevatedButton(
                      child: Text("Sign In with Google"),
                      style: ElevatedButton.styleFrom(primary: Color(0xfff42b51),shape:  StadiumBorder()),
                      onPressed: ()async{context.read<BookServices>().signIn();setState((){});})),
            )


          ],
        ),
      ),
    );
  }
}

