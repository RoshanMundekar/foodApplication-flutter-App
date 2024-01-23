import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodapp/Home/CustomerOrder1.dart';
import 'package:page_transition/page_transition.dart';
import '../Login.dart';
import '../Widgets/constants.dart';
import '../my-globals.dart';
import '../profile.dart';
import '../server.dart';
import 'package:http/http.dart' as http;

import 'cardpro.dart';

class requestpro extends StatefulWidget {

  @override
  State<requestpro> createState() =>_CrequestproState();
}


class _CrequestproState extends State<requestpro> {
  List characterList = [];


  var oneController = TextEditingController();

  void getCharactersfromApi(data) async {
    CharacterApi.getCharacters(data).then((response) {
      setState(() {

        Iterable list = json.decode(response.body);
        print(list);
        characterList.addAll(list);
        print(characterList);
        // Iterable list = json.decode(response.body);
        // characterList = list;
      });
    });
  }
  @override
  void initState() {
    super.initState();
    getCharactersfromApi('None');
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text('PRODUCT REQUESTS'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                padding: const EdgeInsets.only(left: 16, bottom: 20, top: 20),
                child: const Text(
                  'ALL PRODUCTS REQUESTS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: size.height * 0.8,
                child: ListView.builder(
                    itemCount: characterList.length,
                    // scrollDirection: Axis.vertical,
                    // physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(

                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(

                              image: AssetImage('pictures/images/s.png'), // Replace with your image path
                              fit: BoxFit.cover,
                              // You can adjust the fit as per your needs
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 250.0,
                          padding: const EdgeInsets.only(left: 10,),
                          margin: const EdgeInsets.only(bottom: 10, top: 10),
                          width: size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(

                                    height: 190.0,

                                  ),

                                  Positioned(
                                    bottom: 5,
                                    left: 30,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(characterList[index][1].toUpperCase(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                            color: Constants.blackColor,
                                          ),),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(characterList[index][2].toUpperCase(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Constants.blackColor,
                                          ),),
                                        const SizedBox(
                                          height: 5,
                                        ), Text(characterList[index][3].toUpperCase(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Constants.blackColor,
                                          ),),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(characterList[index][4].toUpperCase(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Constants.blackColor,
                                          ),),
                                        const SizedBox(
                                          height: 5,
                                        ),

                                        Text(
                                          characterList[index][6].toUpperCase(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Constants.blackColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),


                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.amber,

                                            ),
                                            onPressed: () async {
                                              Navigator.of(context).pushReplacement(
                                                MaterialPageRoute(
                                                  builder: (BuildContext context) => requestpro(),
                                                ),
                                              );
                                            },
                                            child:  Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                  characterList[index][7].toUpperCase(),
                                                style: TextStyle(fontSize: 25),
                                              ),
                                            ))
                                        // Thanks for watching... code link in the description...

                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              Row(
                                children: [

                                  Container(
                                    padding: const EdgeInsets.only(right: 15,bottom: 185),
                                    child :    IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          size: 30,
                                          color: Colors.black54.withOpacity(.6),
                                        ),
                                        onPressed: () async {

                                          final url = serverurl+"deletepro";
                                          final response = await http.post(Uri.parse(url), body: json.encode({'product' : characterList[index][1]}));

                                          String responseBody = response.body;

                                          if(responseBody == "success"){
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => Login()));
                                          }
                                        }
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        )
    );

  }
}

class CharacterApi {
  static Future getCharacters(data) {
    return http.get(Uri.parse(serverurl+"requestpro/"+globalString));
  }
}




