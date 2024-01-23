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

class CustomerOrder extends StatefulWidget {

  @override
  State<CustomerOrder> createState() =>_CustomerOrderState();
}


class _CustomerOrderState extends State<CustomerOrder> {
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
          title: Text('COSTOMER REQUESTS'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                padding: const EdgeInsets.only(left: 16, bottom: 20, top: 20),
                child: const Text(
                  'ALL PRODUCTS',
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
                        onTap: () {
                          Navigator.push(context, PageTransition(child: Detail(characterList[index]), type: PageTransitionType.bottomToTop));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Constants.primaryColor.withOpacity(.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 100.0,
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
                                    width: 60.0,
                                    height: 60.0,
                                    decoration: BoxDecoration(
                                      color: Constants.primaryColor.withOpacity(.8),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: SizedBox(
                                        height: 80.0,
                                        child:

                                        CircleAvatar(
                                          radius: 73.0,
                                          backgroundColor: Constants.primaryColor,
                                          child:ClipRRect(
                                            borderRadius: BorderRadius.circular(50),
                                            child:  ClipOval(
                                              child: Image.network(serverurl+"static/product/"+characterList[index][2],
                                                width: 58,
                                                height: 58,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        )
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    left: 80,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(characterList[index][1].toUpperCase(),
                                      style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Constants.blackColor,
                                    ),),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          characterList[index][10].toUpperCase(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: Constants.blackColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              Row(
                                children: [

                                  Container(
                                    padding: const EdgeInsets.only(right: 5),
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
    return http.get(Uri.parse(serverurl+"donateproduct/"+globalString));
  }
}




