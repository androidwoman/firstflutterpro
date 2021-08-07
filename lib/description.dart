import 'package:flutter/material.dart';
import 'package:flutterpro/ShoppingBacketData.dart';
import 'package:flutterpro/product.dart';

class description extends StatelessWidget {
  products product;

  description(this.product);

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
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
        body: Builder(
          builder:(context) => Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Align(
                child: Text(
                  "Shoes",
                  style: TextStyle(
                      fontFamily: "Varela", fontSize: 35, color: Colors.red[700]),
                ),
                alignment: Alignment.topCenter,
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Image.network(
                  product.imageUrl,
                  width: 150,
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                product.price,
                style: TextStyle(
                    fontFamily: "Vazir", fontSize: 30, color: Colors.red[700]),
              ),
              Text(
                product.productName,
                style: TextStyle(
                    fontFamily: "Vazir", fontSize: 20, color: Colors.grey[700]),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 45, right: 45),
                child: Text(
                  product.description,
                  style: TextStyle(
                    fontFamily: "Vazir",
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Align(
                    child: Material(
                      child: InkWell(
                        onTap: () {
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "${product.productName} به سبد خرید اضافه شد ",
                                  style: TextStyle(
                                      fontFamily: "Vazir",
                                      fontSize: 15,
                                      color: Colors.white))));
                          print("added to basket ${product.productName}");
                          ShoppingBasketData.getInstance()!.basketItem.add(product);
                          print(
                              ShoppingBasketData.getInstance()!.basketItem.length);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 50,
                          height: 50,
                          child: Center(
                            child: Text(
                              "افزودن به سبد خرید",
                              style: TextStyle(
                                  fontFamily: "Vazir",
                                  fontSize: 15,
                                  color: Colors.white),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.green[400],
                              borderRadius: BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                    ),
                    alignment: Alignment.bottomCenter,
                  ),
                ),
              )
            ],
          ),
        ),

    );
  }
}
