import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterpro/ShoppingBacketData.dart';
import 'package:flutterpro/ShoppingBasket.dart';
import 'package:flutterpro/description.dart';
import 'package:flutterpro/product.dart';
import 'package:http/http.dart';

import 'Branches.dart';
import 'bottomsheet.dart';

void main() {
  // runApp(MaterialApp(
  //   //home: Text('hi betch'),
  //   home: Scaffold(
  //     appBar: AppBar(
  //       title: Text('title'),
  //     ),
  //     // body: Text('body'),
  //     body: Center(
  //       child: Text('body center'),
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: () {  },
  //       child:Icon(
  //         Icons.access_alarms
  //       ),
  //     ),
  //    ),
  // ));
  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: store(),
    );
  }
}

class store extends StatefulWidget {
  const store({Key? key}) : super(key: key);

  @override
  _storeState createState() => _storeState();
}

class _storeState extends State<store> {
  List<products> _items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ShoppingBasketData.getInstance();
    fetchItem();
  }

  //when state change
  @override
  Widget build(BuildContext context) {
    //here

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.map,
              color: Colors.black45,
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Branches()));
            },
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_basket,
              color: Colors.black45,
            ),
            onPressed: () {
              Navigator.of(context).push(PageRouteBuilder(
                  transitionDuration: Duration(seconds: 1),
                  pageBuilder: (BuildContext context, Animation<double> first,
                      Animation<double> second) {
                    return ShoppingBascket();
                  },
                  transitionsBuilder: (BuildContext context,
                      Animation<double> first,
                      Animation<double> second,
                      Widget child) {
                    return SlideTransition(
                        child: child,
                        position: Tween<Offset>(
                                begin: Offset(1, 0), end: Offset(0, 0))
                            .animate(CurvedAnimation(
                                parent: first, curve: Curves.easeInExpo)));
                    //  .animate(first)); //u can use
                  }));
            },
          )
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'فروشگاه',
          style: TextStyle(color: Colors.black45, fontFamily: "Vazir"),
        ),
        centerTitle: true,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black45,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.count(
          crossAxisSpacing: 10,
          mainAxisSpacing: 15,
          crossAxisCount: 2,
          children: List.generate(_items.length, (int position) {
            return generateIteme(_items[position], context);
          }),
        ),
      ),
      bottomNavigationBar: bottomsheet(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.red[900],
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void fetchItem() async {
    var url = Uri.parse("https://welearn.site/flutter/products_list.json");
    Response response = await get(url);
    print(utf8.decode(response.bodyBytes));
    setState(() {
      var productjson = json.decode(utf8.decode(response.bodyBytes));
      for (var i in productjson) {
        var productItem = products(i['product_name'], i['id'], i['price'],
            i['image_url'], i['off'], i['description']);
        _items.add(productItem);
      }
    });
  }
}

Card generateIteme(products product, context) {
  return Card(
    child: InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => description(product)));
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              child: Image.network(product.imageUrl),
            ),
            Text(
              product.productName,
              style: TextStyle(
                  color: Color(0xFF928989), fontFamily: "Vazir", fontSize: 14),
            ),
            Text(
              product.price,
              style: TextStyle(
                  color: Colors.red[700], fontFamily: "Vazir", fontSize: 14),
            )
          ],
        ),
      ),
    ),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30))),

    elevation: 4,
  );
}
