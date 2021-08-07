import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterpro/product.dart';
typedef onRemovepress(int index);
class ShoppingBasketItem extends StatefulWidget {
  products product;
  int _count = 1;
  int _index;
  onRemovepress _removepress;

  ShoppingBasketItem(this.product,this._removepress,this._index);

  @override
  _ShoppingBasketItemState createState() => _ShoppingBasketItemState();
}

class _ShoppingBasketItemState extends State<ShoppingBasketItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        height: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          textDirection: TextDirection.rtl,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 40),
              child: Image.network(
                widget.product.imageUrl,
                width: 100,
                height: 100,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, right: 20),
                  child: Text(
                    widget.product.productName,
                    style: TextStyle(fontFamily: "Vazir", fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      GestureDetector(
                        child: Icon(
                          Icons.chevron_right,
                          size: 35,
                        ),
                        onTap: () {
                          decrement();
                        },
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget._count.toString(),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        child: Icon(
                          Icons.chevron_left,
                          size: 35,
                        ),
                        onTap: () {
                          increment();
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
            Expanded(
                child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 20, left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(child: Icon(Icons.delete_outline),onTap:(){ widget._removepress(widget._index);}),
                    Text(widget.product.price,
                        style: TextStyle(fontFamily: "Vazir", fontSize: 18))
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  void increment() {
    setState(() {
      widget._count++;
    });
  }

  void decrement() {
    setState(() {
      if(widget._count==1)
        widget._removepress(widget._index);
      widget._count--;
    });
  }
}

