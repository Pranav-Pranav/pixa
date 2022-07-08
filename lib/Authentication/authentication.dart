import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/Provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';


class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  @override
  GoogleSignIn _googleSignIn=GoogleSignIn(scopes: ['email']);
  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? _user=_googleSignIn.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){context.read<BookServices>().changeTheme();}, child: Text("Change Theme")),
            ElevatedButton(onPressed: ()async{await _googleSignIn.signOut();await _googleSignIn.signIn();setState((){});}, child: Text("Login with Google")),
            ElevatedButton(onPressed: ()async{await _googleSignIn.signOut();setState((){});}, child: Text("Sign Out")),
            Text(_user==null ? "hello":_user.email),

          ],
        ),
      ),
    );
  }
}
