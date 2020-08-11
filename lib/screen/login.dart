import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:order_app/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  String msg = '';
  void login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = {
      "username": username.text,
      "password": password.text,
    };
    final res = await ApiApp().postURL(data, 'login');
    final body = json.decode(res.body);
    setState(() {
      prefs.setString('id', '${body['id']}');
      prefs.setString('user', body['username']);
      prefs.setString('phone', body['phone']);
      if (body['status'] == 'ok') {
        msg = '';
        Navigator.pushNamed(context, '/home');
      } else {
        msg = 'ຊື່ຜູ່ໃຊ້ ຫຼື ລະຫັດບໍ່ຖືກຕ້ອງ';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Center(
              child: Image.asset(
                'assets/image/logo.png',
                width: 200,
              ),
            ),
            Card(
              margin: EdgeInsets.only(left: 20, right: 20, top: 10),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      '${msg}',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0XFFF8F8F8),
                    ),
                    child: TextField(
                      controller: username,
                      decoration: InputDecoration(
                          hintText: 'ຊື່ຜູ່ໃຊ້',
                          prefixIcon: Icon(
                            Icons.person_outline,
                            size: 30,
                            color: Color(0XFF91A6A6),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 15)),
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 25, right: 25, bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0XFFF8F8F8),
                    ),
                    child: TextField(
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'ລະຫັດຜ່ານ',
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            size: 30,
                            color: Color(0XFF91A6A6),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 15)),
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 60),
                    child: MaterialButton(
                      minWidth: 318,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      color: Color(0XFF990F02),
                      child: Container(
                        padding: EdgeInsets.all(14),
                        child: Text(
                          'ເຂົ້າສູ່ລະບົບ',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                        login();
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: Center(
                child: Text('Register'),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10, left: 50, right: 50),
              child: MaterialButton(
                elevation: 0,
                minWidth: 318,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Colors.blueGrey,
                child: Container(
                  padding: EdgeInsets.all(14),
                  child: Text(
                    'ລົງທະບຽນ',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
