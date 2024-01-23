import 'dart:convert';

import 'package:flutter/material.dart';

import '../../my-globals.dart';

import '../../server.dart';
import 'package:http/http.dart' as http;

import 'Home/constants.dart';
import 'Home/home.dart';

class ProfilePage extends StatefulWidget {


  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {

  String name="";



  List characterList = [];

  void getCharactersfromApi() async {
    CharacterApi.getCharacters().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        print(list);
        characterList.addAll(list) ;



      });
    });



  }

  @override
  void initState() {
    super.initState();
    getCharactersfromApi();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            height: size.height * .9,
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 90,
                ),
                Container(
                  width: 100,
                  child: new CircleAvatar(
                    radius: 50,
                    backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                        ? Constants.primaryColor
                        : Colors.white,
                    backgroundImage: NetworkImage(serverurl+"static/profile/"+characterList[2],

                    ), // Replace with the actual URL of your image
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Constants.blackColor,
                      width: 5.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  name,
                  style: TextStyle(
                    color: Constants.blackColor,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                    height: 22,

                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(

                  obscureText: false,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: Constants.blackColor,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                    ),
                    prefixIcon: Icon(Icons.person, color: Constants.blackColor.withOpacity(.3),),
                    hintText: characterList[1].toString(),
                  ),
                  cursorColor: Constants.blackColor.withOpacity(.5),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(

                  obscureText: false,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: Constants.blackColor,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                    ),
                    prefixIcon: Icon(Icons.email, color: Constants.blackColor.withOpacity(.3),),
                    hintText: characterList[3].toString(),
                  ),
                  cursorColor: Constants.blackColor.withOpacity(.5),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(

                  obscureText: false,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Constants.blackColor,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                    ),
                    prefixIcon: Icon(Icons.numbers, color: Constants.blackColor.withOpacity(.3),),
                    hintText: characterList[5].toString(),
                  ),
                  cursorColor: Constants.blackColor.withOpacity(.5),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(

                  obscureText: true,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: Constants.blackColor,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                    ),
                    prefixIcon: Icon(Icons.lock, color: Constants.blackColor.withOpacity(.3),),
                    hintText: characterList[4].toString(),
                  ),
                  cursorColor: Constants.blackColor.withOpacity(.5),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(

                  obscureText: true,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: Constants.blackColor,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                    ),
                    prefixIcon: Icon(Icons.location_city, color: Constants.blackColor.withOpacity(.3),),
                    hintText: characterList[7].toString(),
                  ),
                  cursorColor: Constants.blackColor.withOpacity(.5),
                ),
                const SizedBox(
                  height: 20,
                ),


              ],
            ),
          ),
        ));
  }
}

class CharacterApi {
  static Future getCharacters() {
    return http.get(Uri.parse(serverurl+"getProfile/"+globalString));
  }
}
