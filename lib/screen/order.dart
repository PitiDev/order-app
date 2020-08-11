import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:order_app/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

final formatter = new NumberFormat("#,###");

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  TextEditingController etc_phone = TextEditingController();
  List _dataOrder = new List();
  int total;
  String amount;
  String phone;
  int _NumberOrder = 0;

  @override
  void initState() {
    // TODO: implement initState
    getOrder();
    gettable();
    super.initState();
  }

  void getOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = {
      "phone": "${prefs.getString('phone')}",
    };
    print('==phone == ${prefs.getString('phone')}');
    final res = await ApiApp().postURL(data, 'get-order');
    final body = json.decode(res.body);
    print('== Order == ${body['data']}');
    print('== Total == ${body['total'][0]['total']}');
    print('== Amount == ${body['amount']}');
    var totalamount = body['amount'];
    setState(() {
      _dataOrder = body['data'] as List;
      total = body['total'][0]['total'];
      amount = totalamount;
    });
  }

  void gettable() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      phone = prefs.getString('phone');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order'),
        backgroundColor: Color(0XFF990F02),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              'ລາຍການສັ່ງອາຫານ',
              style: TextStyle(fontSize: 17),
            ),
          ),
          Container(
            height: 400,
            child: _dataOrder.isEmpty
                ? Container(
                    margin: EdgeInsets.only(top: 100),
                    child: Text(
                      'ທ່ານຍັງບໍ່ມີລາຍການສັ່ງອາຫານ',
                      style: TextStyle(fontSize: 17, color: Colors.redAccent),
                    ),
                  )
                : ListView.builder(
                    itemCount: _dataOrder.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 35,
                              backgroundImage: AssetImage('assets/image/res.jpg'),
                            ),
                            title: Text(
                              '${_dataOrder[index]['name']}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              children: <Widget>[
                                Text('ລາຄາ: ${formatter.format(int.parse(_dataOrder[index]['price']))} Kip'),
                                Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.black12,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.remove,
                                          color: Colors.black,
                                          size: 15,
                                        ),
                                        onPressed: () async {
                                          var data = {
                                            "menu": _dataOrder[index]['menu'].toString(),
                                          };
                                          final res = await ApiApp().postURL(data, 'rm-qty');
                                          final body = json.decode(res.body);
                                          print('== QTY Remove == ${body} ');
                                          getOrder();
                                        },
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                    ),
                                    Text(
                                      '${_dataOrder[index]['qty'] + _NumberOrder}',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                    ),
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.black12,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.black,
                                          size: 15,
                                        ),
                                        onPressed: () async {
                                          SharedPreferences prefs = await SharedPreferences.getInstance();
                                          var data = {
                                            "phone": _dataOrder[index]['phone'].toString(),
                                            "menu": _dataOrder[index]['menu'].toString(),
                                            "status": '0',
                                          };
                                          final res = await ApiApp().postURL(data, 'add-order');
                                          final body = json.decode(res.body);
                                          print('== QTY == ${body} ');
                                          getOrder();
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            trailing: Column(
                              children: <Widget>[
                                IconButton(
                                  onPressed: () async {
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    var data = {
                                      "menu": _dataOrder[index]['menu'].toString(),
                                    };
                                    final res = await ApiApp().postURL(data, 'rm-order');
                                    final body = json.decode(res.body);
                                    print('== Remove== ${body} ');

                                    setState(() {
                                      getOrder();
                                    });
                                  },
                                  color: Color(0XFFE86600),
                                  icon: Icon(Icons.close),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
          ),
          Container(
            margin: EdgeInsets.only(right: 20, top: 30),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'ຈໍານວນທັງໝົດ: ${total} ລາຍການ',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 20),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'ລວມລາຄາທີ່ຕ້ອງຈ່າຍ: ${amount} Kip',
                style: TextStyle(fontSize: 17),
              ),
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.only(right: 20),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'ເບິໂທ: ${phone} ',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black12,
            ),
            child: TextField(
              controller: etc_phone,
              decoration: InputDecoration(
                  hintText: 'ປ້ອນເບິໂທ ກໍລະນີ້ຜູ່ອຶ່ນສັ່ງ',
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
        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 30),
        child: MaterialButton(
          color: Color(0XFF990F02),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('count');
            var data = {
              "phone": prefs.getString('phone'),
              "etc_phone": "${etc_phone.text}",
            };
            final res = await ApiApp().postURL(data, 'comfirm-order');
            final body = json.decode(res.body);

            print(' === Status == ${body['status']}');
            if (body['status'] == 'success') {
              Navigator.pushNamed(context, '/Success');
            }
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'ສັ່ງອາຫານ',
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
