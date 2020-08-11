import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:order_app/api/api.dart';
import 'package:order_app/screen/category.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String phone;

  @override
  void initState() {
    // TODO: implement initState
    gettable();
    super.initState();
  }

  void gettable() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      phone = prefs.getString('user');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'ຜູ່ໃຊ້: ${phone}',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0XFF990F02),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 15, bottom: 5),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.black12,
              child: IconButton(
                icon: Icon(
                  Icons.power_settings_new,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: () async {
                  Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
                },
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(
            height: 550,
            child: Category(),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 30),
        child: MaterialButton(
          color: Color(0XFF990F02),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          onPressed: () async {
            Navigator.pushNamed(context, '/cus-order');
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'ລາຍການອາຫານທີ່ທ່ານສັ່ງແລ້ວ',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
