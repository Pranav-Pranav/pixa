import 'package:provider/provider.dart';
import '/Provider/provider.dart';
import 'package:flutter/material.dart';


class Issued extends StatefulWidget {
  String email;
  List<Map<String,dynamic>>books;
  Issued({required this.email,required this.books});
  @override
  State<Issued> createState() => _IssuedState(email:email,books: books);
}

class _IssuedState extends State<Issued> {
  @override
  String email;
  List<Map<String,dynamic>>books;
  _IssuedState({required this.email,required this.books});

  Widget build(BuildContext context) {
    List<Map<String,dynamic>>books=context.watch<BookServices>().books;
    return Scaffold(body:
    ListView(
      children: books.map((book) => book["status"]=="${context.watch<BookServices>().user!.email}"?BookTile(book: book,email: email):SizedBox(height: 0)).toList(),
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
          ],
        ));
  }
}


