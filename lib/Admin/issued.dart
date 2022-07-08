import 'package:provider/provider.dart';
import '/Provider/provider.dart';
import 'package:flutter/material.dart';
void returnBook(Map<String,dynamic> book, BuildContext context,String user) async{
  book["status"]=user;//ASSIGN A USER

  Future<void> issue(book) async{
    context.read<BookServices>().update(book);
  } //ISSUES THE PASSED BOOK , TRIGGERED FROM YES OF ALERT BOX

  //OPEN ALERT BOX
  showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Return the following book?"),
          content: Text("${book['title']} by  ${book['author']}"),
          actions: [
            ElevatedButton(style: ElevatedButton.styleFrom(primary: Color(0xfff42b51),shape:  StadiumBorder()),onPressed: (){issue(book).then((value) => Navigator.of(context).pop());}, child: Text("Yes")),
            ElevatedButton(style: ElevatedButton.styleFrom(primary: Color(0xfff42b51),shape:  StadiumBorder()),onPressed: (){Navigator.of(context).pop();}, child: Text("No"))
          ],
        );
      }
  );

//IF YES THEN SEND MAP TO PROVIDER FUNCTION WHICH WILL SEND IT TO FIREBASE
//ELSE LEAVE
}
void delete(Map<String,dynamic> book, BuildContext context) async{
  //ASSIGN A USER
  TextEditingController title=TextEditingController();
  TextEditingController author=TextEditingController();
  Future<void> delete(book) async{
    context.read<BookServices>().delete(book["id"]);
  } //ISSUES THE PASSED BOOK , TRIGGERED FROM YES OF ALERT BOX

  //OPEN ALERT BOX
  showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Delete the following book?"),
          content:Text("Do you want to delete ${book["title"]} by ${book["author"]}?"),
          actions: [
            ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.black,shape:  StadiumBorder()),onPressed: (){delete(book).then((value) => Navigator.of(context).pop());}, child: Text("Yes")),
            ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.black,shape:  StadiumBorder()),onPressed: (){Navigator.of(context).pop();}, child: Text("Cancel"))
          ],
        );
      }
  );

//IF YES THEN SEND MAP TO PROVIDER FUNCTION WHICH WILL SEND IT TO FIREBASE
//ELSE LEAVE
}


class Issued extends StatefulWidget {
  List<Map<String,dynamic>>books;
  Issued({required this.books});
  @override
  State<Issued> createState() => _IssuedState(books: books);
}

class _IssuedState extends State<Issued> {
  @override
  List<Map<String,dynamic>>books;
  _IssuedState({required this.books});

  Widget build(BuildContext context) {
    return Scaffold(
        body:
        ListView(
          children: books.map((book) => book["status"]=="available"?SizedBox(height: 0):BookTile(book: book)).toList(),
        ));
  }
}


class BookTile extends StatefulWidget {
  Map<String,dynamic> book;
  BookTile({required this.book});
  @override
  State<BookTile> createState() => _BookTileState(book: book);
}

class _BookTileState extends State<BookTile> {
  Map<String,dynamic> book;
  _BookTileState({required this.book});

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
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${book["status"]}",style: TextStyle(fontWeight: FontWeight.bold),),
                ),

              ],),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ElevatedButton(child: Text("Return"),style: ElevatedButton.styleFrom(primary: Color(0xfff42b51),shape:  StadiumBorder()),onPressed: book["status"]=="available"?null:(){returnBook(book,context,"available");},),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ElevatedButton(child: Text("Delete"),style: ElevatedButton.styleFrom(primary: Colors.black,shape:  StadiumBorder()),onPressed: (){delete(book,context);},),
                ),
              ],),
          ],
        ));
  }
}


