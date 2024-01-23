import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodapp/Home/BuyProducts.dart';
import 'package:foodapp/Home/requestpro.dart';
import 'package:foodapp/Login.dart';
import 'package:foodapp/addfood.dart';
import 'package:http/http.dart' as http;
import '../Widgets/constants.dart';
import '../addrequestpro.dart';
import '../main.dart';
import '../my-globals.dart';
import '../profile.dart';
import '../server.dart';
import 'cardpro.dart';
import 'package:page_transition/page_transition.dart';

import 'order.dart';

class MyHomePage1 extends StatefulWidget {
  @override
  _MyHomePage1State createState() => _MyHomePage1State();
}

class _MyHomePage1State extends State<MyHomePage1>
    with SingleTickerProviderStateMixin {


  final TextEditingController foodtype = TextEditingController();
  final TextEditingController quantity = TextEditingController();
  final TextEditingController deloption = TextEditingController();

  final List<String> _options = ['Select','fruits', 'vegetables ', 'Meats', 'canned goods', 'Others'];
  String? _selectedValue; // Track the selected value
  bool _isDropdownVisible = false;
  String? _selectedOption;



  final List<String> _options2 = ['Select','Pickup', 'Delivery', 'both'];
  String? _selectedValue2; // Track the selected value
  bool _isDropdownVisible2 = false;


  List characterList = [];
  List mainlst = [];
  var oneController = TextEditingController();

  void getCharactersfromApi(data) async {
    CharacterApi.getCharacters(data).then((response) {
      setState(() {
        characterList.clear();
        Iterable list = json.decode(response.body);
        characterList.addAll(list);
        mainlst.addAll(list);
        // Iterable list = json.decode(response.body);
        // characterList = list;
      });
    });
  }
  void filterData() {
    // characterList.clear();
    if(_selectedValue == "Select" &&  _selectedValue2 == "Select"){
      setState(() {
        characterList = mainlst;
      });
    }
    else{
      // var filteredList = mainlst.where((o) => o['category'].toLowerCase().startsWith(message) || o['name'].toLowerCase().startsWith(message)).toList();
      var filteredList = mainlst.where((o) => o[3]==_selectedValue || o[5]==_selectedValue2).toList();
      if (filteredList.length != 0){
        setState(() {
          characterList = filteredList;
        });
      }
      else{
        setState(() {
          characterList = [];
        });
      }
    }
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
        appBar: new AppBar(
          title: new Text("HOME PAGE"),
          backgroundColor: Color(0xFF399D63),
        ),
        drawer: Drawer(
          child: new ListView(
            children: [
              new UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Constants.primaryColor,
                ),
                accountName: new Text(globalHeaderMob),
                accountEmail: new Text(globalHeaderEmail),
                currentAccountPicture: new CircleAvatar(
                  backgroundColor:
                  Theme.of(context).platform==TargetPlatform. iOS
                      ? Constants.primaryColor
                      :Colors.white,
                  child: new Text(globalString[0].toUpperCase(),style: TextStyle(color: Constants.primaryColor),),
                ),
              ),
              new ListTile(
                title: new Text("HOME"),
                trailing: new Icon(Icons.home),
                onTap: (){
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>MyHomePage1()));
                },
              ),
              new ListTile(
                title: new Text("PRODUCT  REQUEST"),
                trailing: new Icon(Icons.add),
                onTap: (){
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>requestpro()));
                },
              ),
              new ListTile(
                title: new Text("BUY PRODUCTS"),
                trailing: new Icon(Icons.payment),
                onTap: (){
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>buypro()));
                },
              ),
              new ListTile(
                title: new Text("FOOD REQUEST"),
                trailing: new Icon(Icons.payment),
                onTap: (){
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>addrequestpro()));
                },
              ),

              new ListTile(
                  title: new Text("PROFILE"),
                  trailing: new Icon(Icons.person),
                onTap: (){
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>ProfilePage()));
                },
              ),
              new ListTile(
                  title: new Text("LOGOUT"),
                  trailing: new Icon(Icons.logout),
                  onTap: ()=> Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>Home()))
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 5.0),
                width: 120,
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedValue,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedValue = newValue!;
                          });
                          filterData();
                        },
                        items: _options.map((option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Food type',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.arrow_drop_down),
                        ),
                      ),
                    ),
                    SizedBox(width: 10), // Add spacing between the dropdowns

                   // Add spacing between the dropdowns
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedValue2,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedValue2 = newValue!;
                          });

                          filterData();
                        },
                        items: _options2.map((option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Quantity',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.arrow_drop_down),
                        ),
                      ),
                    ),
                  ],
                )
                ,
              ),
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
                          Navigator.push(context, PageTransition(child: DetailPage1(characterList[index]), type: PageTransitionType.bottomToTop));
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
                                        // Image.asset('assets/images/plant-one.png'),
                                        // Image.network(serverurl+"static/"+characterList[index][0]),
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
                                          height: 8,
                                        ),
                                        Text(
                                          characterList[index][10],

                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ));
  }
  void _toggleDropdown() {
    setState(() {
      _isDropdownVisible = !_isDropdownVisible;
    });
  }



  void _toggleDropdown2() {
    setState(() {
      _isDropdownVisible2 = !_isDropdownVisible2;
    });
  }
}
class CharacterApi {
  static Future getCharacters(data) {
    return http.get(Uri.parse(serverurl+"getAllproduct/"+globalString));
  }
}
