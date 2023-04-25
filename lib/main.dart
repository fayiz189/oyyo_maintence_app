import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oyyo_maintence_app/Loging/login.dart';
import 'package:oyyo_maintence_app/Loging/spashscreen.dart';
import 'package:oyyo_maintence_app/bottomNavbar.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}



class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override

  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Splash(),

    );
  }
}



Future<bool> alert(
    BuildContext context,
    String message,
    ) async {
  bool result = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0)),
        title: Text('Are you sure ?'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(false);
            },
            child: Text('No',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(true);
            },
            child: Text('Yes',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red)),
          )
        ],
      ));
  return result;
}


//complaint
//status 0= request
// 1 = accepted
// 2 = scheduled
// 3