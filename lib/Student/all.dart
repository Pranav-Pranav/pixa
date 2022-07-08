import 'package:provider/provider.dart';
import '/Provider/provider.dart';
import 'package:flutter/material.dart';
void issueBook(Map<String,dynamic> book, BuildContext context,String user) async{
  book["status"]=user;//ASSIGN A USER

  Future<void> issue(book) async{
    context.read<BookServices>().update(book);
  } //ISSUES THE PASSED BOOK , TRIGGERED FROM YES OF ALERT BOX

  //OPEN ALERT BOX
  showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Do you want to issue the following book?"),
          content: Text("Title     : ${book['title']}\nAuthor :  ${book['author']}"),
          actions: [
            ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.black,shape:  StadiumBorder()),onPressed: (){issue(book).then((value) => Navigator.of(context).pop());}, child: Text("Yes")),
            ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.black,shape:  StadiumBorder()),onPressed: (){Navigator.of(context).pop();}, child: Text("No"))
          ],
        );
      }
  );

//IF YES THEN SEND MAP TO PROVIDER FUNCTION WHICH WILL SEND IT TO FIREBASE
//ELSE LEAVE
}


class All extends StatefulWidget {
  String email;
  List<Map<String,dynamic>>books;
  All({required this.email,required this.books});
  @override
  State<All> createState() => _AllState(email:email,books: books);
}

class _AllState extends State<All> {
  @override
  String email;
  List<Map<String,dynamic>>books;
  _AllState({required this.email,required this.books});

  Widget build(BuildContext context) {
    return Scaffold(body:
    ListView(
      children: books.map((book) => BookTile(book: book,email: email)).toList(),
    ));
  }
}


class BookTile extends StatefulWidget {
  Map<String,dynamic> book;
  String email;
  BookTile({required this.book,required this.email});
  @override
  State<BookTile> createState() => _BookTileState(book: book,email:email);
}

class _BookTileState extends State<BookTile> {
  Map<String,dynamic> book;
  String email;
  _BookTileState({required this.book,required this.email});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${book["title"]}",style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${book["author"]}"),
                )
              ],),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ElevatedButton(child: Text("  Issue "),style: ElevatedButton.styleFrom(primary: Color(0xfff42b51),shape:  StadiumBorder()),onPressed: book["status"]=="available"?(){issueBook(book,context,email);}:null),
                ),

              ],),
          ],
        ));
  }
}


