import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Home/home.dart';
import 'Home/home2.dart';
import 'Login.dart';
import 'Signup.dart';
import 'Theme/Color.dart';
import 'profile.dart';
import 'Widgets/CustomButton.dart';

void main() {

  runApp(const MyApp(

  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "RalewatMedium",
          primaryColor: primaryColor,
          primaryIconTheme: IconThemeData(
              color: Colors.white
          ),
          primarySwatch: Colors.green,
          primaryTextTheme: TextTheme(
            headline6: TextStyle(
                color: Colors.white
            ),

          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: primaryColor
          )
      ),
      title: "Foody",
      home:  Home(),
      routes: {
        '/login': (context) => Login(),
        '/register': (context) => Signup(),
        '/home': (context) => MyHomePage(),
        '/home2': (context) => MyHomePage1(),
        // '/profile': (context) => ProfilePage(),
        // '/home': (context) => MyHomePage(),
      },
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Image.asset(
              "pictures/images/s.png",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  ("GiftGoods").toUpperCase(),
                  style: TextStyle(fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                   ),

                ),
                SizedBox(
                  height: 15.0,
                ),
                CustomButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Signup()));
                  },
                  text: "Sign Up",
                  color: Colors.green,
                  width: 250.0,
                ),
                SizedBox(
                  height: 5.0,
                ),
                CustomButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  text: "Log In",
                  color: Colors.black,
                  width: 250.0,
                ),
                SizedBox(
                  height: 50.0,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
