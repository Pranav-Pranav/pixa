import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

class BookServices with ChangeNotifier{
  ThemeMode theme=ThemeMode.dark;
  GoogleSignIn _googleSignIn=GoogleSignIn(scopes: ['email']);
  GoogleSignInAccount? user;
  List<Map<String,dynamic>>books=[];
  FirebaseFirestore db= FirebaseFirestore.instance;
  int admin=0;


  void adminSignin() async{
    admin=1;
    notifyListeners();
  }
  void studentSignin() async{
    admin=2;
    notifyListeners();
  }

  void adminSignout(){
    admin=0;
    notifyListeners();
  }

  void initfetchBooks()async{
    books=[];
   await db.collection("Books").get().then((event) {
     for (var doc in event.docs) {
       Map<String,dynamic> book={"id":"","title":"","author":"","status":""};//MAP OF BOOK
       book["id"]=doc.id;
       book["title"]=doc.data()['title'];
       book["author"]=doc.data()['author'];
       book["status"]=doc.data()['status'];
       //db.collection("Books").doc(doc.id).set({"status":"available"},SetOptions(merge: true)); //  FOR EDITING THROUGH CODE
       books.add(book);
     }
   });//ADD BOOK TO BOOKS
    print(books);

  }
  void delete(String id)async{
    db.collection("Books").doc(id).delete();
    fetchBooks();
    notifyListeners();
    print("deleted");
  }
  void fetchBooks()async{
    books=[];
    await db.collection("Books").get().then((event) {
      for (var doc in event.docs) {
        Map<String,dynamic> book={"id":"","title":"","author":"","status":""};//MAP OF BOOK
        book["id"]=doc.id;
        book["title"]=doc.data()['title'];
        book["author"]=doc.data()['author'];
        book["status"]=doc.data()['status'];
        books.add(book);
        db.collection("Books").doc(doc.id).set(book,SetOptions(merge: true));
      }
    });//ADD BOOK TO BOOKS
    print("books added");
    notifyListeners();

  }
  void addBook(Map<String,dynamic> book)async{

    try{db.settings=Settings(
        persistenceEnabled: true,
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);}
    catch(error){print(error);}// ENABLE CACHE

    await db.collection("Books").add(book);
    fetchBooks();
    notifyListeners();

  }
  void update(Map<String,dynamic> book)async{
    try{db.settings=Settings(
        persistenceEnabled: true,
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);}
    catch(error){print(error);}// ENABLE CACHE

    await db.collection("Books").doc(book['id']).set(book,SetOptions(merge: true));
    fetchBooks();
    notifyListeners();
  }
  void changeTheme(){
    if(theme==ThemeMode.dark){
      theme=ThemeMode.light;
      notifyListeners();
    }
    else{
      theme=ThemeMode.dark;
      notifyListeners();

    }
  }
  void signIn()async{
    await _googleSignIn.signOut();
    await _googleSignIn.signIn();
    user=_googleSignIn.currentUser;
    print(user);
    notifyListeners();
  }
  void signOut()async{
    await _googleSignIn.signOut();
    user=_googleSignIn.currentUser;
    print(user);
    notifyListeners();
  }
}