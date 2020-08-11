import 'package:flutter/material.dart';
import 'package:order_app/screen/bill_success.dart';
import 'package:order_app/screen/cus_order.dart';
import 'package:order_app/screen/home.dart';
import 'package:order_app/screen/login.dart';
import 'package:order_app/screen/menufood.dart';
import 'package:order_app/screen/order.dart';
import 'package:order_app/screen/register.dart';
import 'package:order_app/screen/success.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'lao'),
        home: Login(),
        routes: <String, WidgetBuilder>{
          '/login': (_) => Login(),
          '/home': (_) => Home(),
          '/menufood': (_) => Menufood(),
          '/order': (_) => Order(),
          '/Success': (_) => Success(),
          '/cus-order': (_) => CusOrder(),
          '/bill-success': (_) => BillSuccess(),
          '/register': (_) => Register()
        });
  }
}
