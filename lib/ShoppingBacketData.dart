import 'package:flutterpro/product.dart';

class ShoppingBasketData{
  static ShoppingBasketData? _shoppingBasketData;
  List<products> _basketItem=[];

  ShoppingBasketData(){
   _basketItem=[];
  }

  List<products> get basketItem => _basketItem;

  set basketItem(List<products> value) {
    _basketItem = value;
  }

  static ShoppingBasketData? getInstance() {
    if(_shoppingBasketData==null) {
      _shoppingBasketData=ShoppingBasketData();
    }
    return _shoppingBasketData;
  }
}