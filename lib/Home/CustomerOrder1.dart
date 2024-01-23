import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodapp/Home/home2.dart';
import 'package:foodapp/my-globals.dart';

import 'package:http/http.dart' as http;
import '../screens/home_screen.dart';
import '../server.dart';
import 'constants.dart';


class Detail extends StatefulWidget {
  final List a;

  Detail(this.a);

  @override
  State<Detail> createState() => _DetaileState(a);
}

class _DetaileState extends State<Detail> {
  final List _plantList1;

  _DetaileState(this._plantList1);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      // welcome to my channel...
      // product card design with flutter... let's started...
      child: Wrap(
        children: [
          Card(
            color: Colors.white,
            elevation: 10,
            child: Container(
              width: 400,
              height: 640,
              child: Column(
                children: [
                  // here place your image link..
                  Image.network(
                    serverurl + "static/product/" + _plantList1[2],
                    width: 200, // Set the width you desire
                    height: 220, // Set the height you desire
                    fit: BoxFit.cover, // Adjust the fit as needed
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    _plantList1[1],
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "RECEIVER NAME",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    _plantList1[9],
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "STATUS",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    _plantList1[10],
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),


                  const SizedBox(
                    height: 15,
                  ),


                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                      ),
                      onPressed: () async {

                        final url = serverurl+"Donatedpro";
                        final response = await http.post(Uri.parse(url), body: json.encode({'productname' :_plantList1[1],'username' : _plantList1[9], 'img' : _plantList1[2]}));

                        String responseBody = response.body;

                        if(responseBody == "success"){
                          Navigator.pop(context);
                        }
                      },
                      child:  Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "ACEPT",
                          style: TextStyle(fontSize: 25),
                        ),
                      ))
                  // Thanks for watching... code link in the description...

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}