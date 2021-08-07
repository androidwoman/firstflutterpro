import 'package:flutter/material.dart';
import 'package:flutterpro/LoginPage.dart';

class bottomsheet extends StatelessWidget {
  const bottomsheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        color: Colors.white,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width / 2 - 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.home,
                    color: Colors.blueGrey[600],
                  ),
                  InkWell(
                    child: Icon(
                      Icons.person_outlined,
                      color: Colors.blueGrey[600],
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                  )
                ],
              ),
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width / 2 - 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.blueGrey[600],
                  ),
                  Icon(
                    Icons.shopping_basket,
                    color: Colors.blueGrey[600],
                  )
                ],
              ),
            )
          ],
        ),
      ),
      shape: CircularNotchedRectangle(),
      notchMargin: 10,
      clipBehavior: Clip.antiAlias,
    );
  }
}
