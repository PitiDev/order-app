import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:order_app/api/api.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();

  void register() async {
    var data = {
      "username": "${username.text}",
      "password": "${password.text}",
      "phone": "${phone.text}",
    };
    final res = await ApiApp().postURL(data, 'register');
    final body = json.decode(res.body);
    print('== register = ${body}');
    setState(() {
      if (body['status'] == 'ok') {
        Navigator.pushNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ລົງທະບຽນນໍາໃຊ້'),
        backgroundColor: Color(0XFFEF6E00),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Center(
              child: Text(
                'ລົງທະບຽນນໍາໃຊ້',
                style: TextStyle(fontSize: 30),
              ),
            ),
            Card(
              margin: EdgeInsets.only(left: 20, right: 20, top: 30),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 25, right: 25, top: 60, bottom: 20),
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
                    margin: EdgeInsets.only(left: 25, right: 25, top: 0, bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0XFFF8F8F8),
                    ),
                    child: TextField(
                      controller: phone,
                      decoration: InputDecoration(
                          hintText: 'ເບີໂທ',
                          prefixIcon: Icon(
                            Icons.phone,
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
                      color: Colors.blueGrey,
                      child: Container(
                        padding: EdgeInsets.all(14),
                        child: Text(
                          'ລົງທະບຽນ',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                        register();
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
