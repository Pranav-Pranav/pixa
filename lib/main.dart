import 'package:flutter/material.dart';
import 'package:pixa/Provider/provider.dart';
import 'package:provider/provider.dart';
import 'Provider/provider.dart';
import 'Authentication/authentication.dart';
import 'Test/test.dart';
import 'package:firebase_core/firebase_core.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyDArVkQz7iS6CjdjbLYRH-BFjjNRnIExRU",
        appId: "1:16066676107:android:b9caa08b56d8e51d379b8e",
        messagingSenderId: "16066676107",
        projectId: "suttlib-d14ea"
    ),
  );
  runApp(
      MultiProvider(
        providers: [ChangeNotifierProvider(create: (_)=>BookServices())],
        child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    context.read<BookServices>().initfetchBooks();
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: context.watch<BookServices>().theme, //context.watch<BookServices>().theme,
      darkTheme: ThemeData(brightness: Brightness.dark),
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Test();
  }
}
