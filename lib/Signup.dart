import 'package:flutter/material.dart';
import 'package:foodapp/Login.dart';
import 'package:foodapp/Profiles.dart';
import 'package:foodapp/addfood.dart';
import '../../Widgets/PageHeader.dart';
import '../../Widgets/CustomButton.dart';
import '../../Widgets/FormInputDecoration.dart';

import '../../Widgets/Loader.dart';

import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'profile.dart';


class Signup extends StatefulWidget {

  createState() => SignupState();

}

class SignupState extends State<Signup> {





  final  TextEditingController usernameController = TextEditingController();
  final TextEditingController  emailController = TextEditingController();
  final  TextEditingController passwordController = TextEditingController();
  final TextEditingController contactController = TextEditingController();







  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: Builder(

            builder: (context) {
          return Stack(
            children: <Widget>[
              SignupForm(context),

            ],
          );
        })));
  }


  Widget SignupForm(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            PageHeader(title: "Register Now"),
            SizedBox(
              height: 30.0,
            ),
            TextFormField(

              controller: usernameController,
              textInputAction: TextInputAction.next,

              style: FormInputDecoration.customTextStyle(),

              textCapitalization: TextCapitalization.none,
              decoration: FormInputDecoration.formInputDesign(name: "Username"),


            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(

              controller: emailController,
              keyboardType: TextInputType.emailAddress,

              textInputAction: TextInputAction.next,
              style: FormInputDecoration.customTextStyle(),

              textCapitalization: TextCapitalization.none,
              decoration:
                  FormInputDecoration.formInputDesign(name: "Email Address"),


            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(

              controller: passwordController,
              textInputAction: TextInputAction.next,

              obscureText: true,
              style: FormInputDecoration.customTextStyle(),

              textCapitalization: TextCapitalization.none,
              decoration: FormInputDecoration.formInputDesign(name: "Password"),


            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(

              textInputAction: TextInputAction.done,
              controller: contactController,
              obscureText: true,
              style: FormInputDecoration.customTextStyle(),

              textCapitalization: TextCapitalization.none,
              decoration:
                  FormInputDecoration.formInputDesign(name: "Contact Number"),


            ),
            SizedBox(
              height: 20.0,
            ),
            CustomButton(
              text: "Sign up",
              color: Colors.green,
              onPressed: () {
                String username = usernameController.text;
                String email = emailController.text;
                String password = passwordController.text;
                String contact = contactController.text;

                RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");
                RegExp phoneRegExp = RegExp(r"^\d{10}$");

                if (username.isEmpty || email.isEmpty || password.isEmpty || contact.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Error"),
                      content: Text("Please enter all values."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("OK"),
                        ),
                      ],
                    ),
                  );
                } else if (!emailRegExp.hasMatch(email)) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Error"),
                      content: Text("Please enter a valid email."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("OK"),
                        ),
                      ],
                    ),
                  );
                } else if (!phoneRegExp.hasMatch(contact)) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Error"),
                      content: Text("Please enter a valid 10-digit phone number."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("OK"),
                        ),
                      ],
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profiles(
                        username: username,
                        email: email,
                        password: password,
                        contact: contact,
                      ),
                    ),
                  );
                }
              },
            ),




            Container(
              height: 50.0,
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                "OR",
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
              ),
            ),
            CustomButton(
              text: "Connect with facebook",
              color: Colors.indigo,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => addfoods()));
              },
            ),
            SizedBox(
              height: 5.0,
            ),
            CustomButton(
              text: "Connect with twitter",
              color: Colors.blue,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => addfoods()));
              },
            ),
          ],
        ),
      ),
    ));
  }

}




