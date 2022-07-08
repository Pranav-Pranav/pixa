import 'package:flutter/material.dart';
import 'package:pixa/Provider/provider.dart';
import 'package:provider/provider.dart';
import '/Provider/provider.dart';


class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    bool switchState=context.watch<BookServices>().theme==ThemeMode.dark?true:false;

    return Scaffold(body: ListView(
        children: [
          ListTile(leading: Icon(Icons.sunny_snowing),title:Text("Dark Mode"),trailing: Switch.adaptive(value: switchState,onChanged: (bool value){setState((){switchState=value;context.read<BookServices>().changeTheme();});},)),
          ListTile(leading: Icon(Icons.request_page),title:Text("Terms and Conditions"),),
          ListTile(leading: Icon(Icons.question_mark),title:Text("About"),),
          ListTile(leading: Icon(Icons.contact_phone),title:Text("Contact Us"),),

        ]));
  }
}
