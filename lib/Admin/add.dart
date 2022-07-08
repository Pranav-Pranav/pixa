
import 'package:flutter/material.dart';
import 'package:pixa/Provider/provider.dart';
import 'package:provider/provider.dart';
import '/Provider/provider.dart';

void registerBook(String title,String author,BuildContext context){
  Map<String,dynamic> book={"title":title,"author":author,"status":"available"};
  context.read<BookServices>().addBook(book);
}
class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  @override
  Widget build(BuildContext context) {
TextEditingController title=TextEditingController();
TextEditingController author=TextEditingController();

    return Scaffold(body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Add \nBooks",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width/1.25,
                child: TextField(
                  controller: title,
                    decoration: InputDecoration(
                        labelText: 'title*',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width/1.25,
                child: TextField(
                  controller: author,
                    decoration: InputDecoration(
                        labelText: 'author*',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))),
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
                    child: Text("Register Book"),
                    style: ElevatedButton.styleFrom(primary: Colors.black,shape:  StadiumBorder()),
                    onPressed: ()async{registerBook(title.text, author.text, context);})),
          ),


        ],
      ),
    ));
  }
}
