import 'package:flutter/material.dart';
import 'package:flutterpro/ShoppingBacketData.dart';
import 'package:flutterpro/ShoppingBasketItem.dart';

class ShoppingBascket extends StatefulWidget {
  const ShoppingBascket({Key? key}) : super(key: key);

  @override
  _ShoppingBascketState createState() => _ShoppingBascketState();
}

class _ShoppingBascketState extends State<ShoppingBascket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'سبد خرید',
          style: TextStyle(color: Colors.black45, fontFamily: "Vazir"),
        ),
        centerTitle: true,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black45,
        ),
      ),
      body: BasketUi(),
    );
  }

  Widget BasketUi() {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: ListView.builder(
          itemCount: ShoppingBasketData.getInstance()!.basketItem.length,
          itemBuilder: (context, position) {
            return GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ShoppingBasketItem(
                    ShoppingBasketData.getInstance()!.basketItem[position],
                    removeItem,
                    position),
              ),
            );
          },
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 80,
          color: Colors.red,
          child: Center(
            child: Text(
              'پرداخت',
              style: TextStyle(
                  color: Colors.white, fontFamily: "Vazir", fontSize: 20),
            ),
          ),
        ),
      )
    ]);
  }

  void removeItem(int index) {
    setState(() {
      ShoppingBasketData.getInstance()!.basketItem.removeAt(index);
    });
  }
}
