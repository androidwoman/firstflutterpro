import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterpro/LoginResponseModel.dart';
import 'package:flutterpro/main.dart';
import 'package:http/http.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var usernameContoroller = TextEditingController();
  var passwordContoroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            'ورود',
            style: TextStyle(color: Colors.black45, fontFamily: "Vazir"),
          ),
          centerTitle: true,
          leading: Icon(
            Icons.arrow_back,
            color: Colors.black45,
          ),
        ),
        body: LoginUi());
  }

  LoginUi() {
    return Builder(
      builder: (context) => Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 20),
            child: Text(
              "SignIn",
              style: TextStyle(
                  color: Colors.grey[400], fontFamily: "Vazir", fontSize: 55),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 50, left: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Material(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "نام کاربری",
                          border: InputBorder.none,
                          icon: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Icon(
                              Icons.perm_identity_outlined,
                              color: Colors.grey[500],
                            ),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20)),
                      style: TextStyle(fontFamily: "Vazir", fontSize: 20),
                      textAlign: TextAlign.center,
                      controller: usernameContoroller,
                    ),
                    elevation: 20,
                    borderRadius: BorderRadius.circular(40),
                    shadowColor: Colors.grey[200],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Material(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "رمز عبور",
                          border: InputBorder.none,
                          icon: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Icon(
                              Icons.lock_outline_sharp,
                              color: Colors.grey[500],
                            ),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20)),
                      obscureText: true,
                      style: TextStyle(fontFamily: "Vazir", fontSize: 20),
                      textAlign: TextAlign.center,
                      controller: passwordContoroller,
                    ),
                    elevation: 20,
                    borderRadius: BorderRadius.circular(40),
                    shadowColor: Colors.grey[200],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Material(
                    elevation: 20,
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.red[900],
                    child: InkWell(
                      onTap: () {
                        sendLoginResponse(usernameContoroller.text,
                            passwordContoroller.text, context);
                      },
                      child: Container(
                        height: 60,
                        child: Center(
                          child: Text(
                            "ورود",
                            style: TextStyle(
                                fontFamily: "Vazir",
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void sendLoginResponse(@required String username, @required String password,
      @required BuildContext context) async {
    var url = "https://welearn.site/flutter/api/?type=login";
    var body = Map<String, dynamic>();
    print("username" +username);
    body["username"] = username;
    body["password"] = password;
    Response response = await post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      //ok
      var Loginjson = json.decode(utf8.decode(response.bodyBytes));
      var model = LoginResponseModel(Loginjson["result"], Loginjson["message"]);
      //print("ok");
       showMySnackBar(context, model.message);
      if(model.result==1){
        Navigator.of(context).pushReplacement(PageRouteBuilder(
            transitionDuration: Duration(seconds: 1),
            pageBuilder: (BuildContext context, Animation<double> first,
                Animation<double> second) {
              return store();
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> first,
                Animation<double> second,
                Widget child) {
              return ScaleTransition(
                  child: child,
                  scale: Tween<double>(
                      begin: 0, end: 1)
                      .animate(CurvedAnimation(
                      parent: first, curve: Curves.easeInExpo)));
              //  .animate(first)); //u can use
            }));
      }

    } else {
      //error
      //print("fucked up");
      showMySnackBar(context, "درخواست با خطا مواجه شد.");
    }
  }

  void showMySnackBar(BuildContext context, String massage) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(massage,
            style: TextStyle(
              fontFamily: "Vazir",
              fontSize: 15,
            ))));
  }
}
