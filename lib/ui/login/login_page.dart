import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sentinel/helpers/routers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../site/site_list.dart';

class LoginPage extends StatefulWidget {
//  static const routeName = '/loginPage';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final focus = FocusNode();
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();
  var account = {
    'username' : 'dfg@gmail.com',
    'password' : '@Qq123',
  };

  SharedPreferences logindata;
  bool newuser;
  String username;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_if_already_login();
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => SiteList()));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color(0xff002057),
                Color(0xff002E7C),
                Color(0xff003CA2),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _logoSection(),
                _textSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _setLogged(BuildContext context, logindata, username_controller) {
    String username = username_controller.text;

    logindata.setBool('login', false);
    logindata.setString('username', username);
    Navigator.pushNamed(context, Routers.LIST);
  }

  Expanded _textSection() {
    return Expanded(
      flex: 3,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 440.0,
        margin: EdgeInsets.all(20.0),
        padding: EdgeInsets.fromLTRB(30, 35, 30, 25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: 33.0,
                  color: Colors.black,
//                fontFamily: ,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 40.0),
              child: Text(
                "Login to your account",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xffACB1C0),
//                fontFamily: ,
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                      // ignore: missing_return
                      validator: (value) {
                        Pattern pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regex = new RegExp(pattern);
                        if (!regex.hasMatch(value)) return 'Enter Valid Email';
                        if (value.isEmpty) return "You can't have an empty username.";
                        if (value.trim() != account['username']) return "Email not match";
                      },
                      controller: username_controller,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofocus: true,
                      onFieldSubmitted: (v) => FocusScope.of(context).requestFocus(focus),
                      decoration: const InputDecoration(
                        fillColor: Color(0xffACB1C0),
                        filled: true,
                        hintText: ' Email',
                        enabledBorder: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(5.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 40.0),
                    child: TextFormField(
                      // ignore: missing_return
                      validator: (value) {
                        Pattern pattern =
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
                        RegExp regex = new RegExp(pattern);
                        if (value.isEmpty) {
                          return "You can't have an empty password.";
                        }
                        if (value.length < 6) {
                          return "Password must be more than 6 character.";
                        }
                        if (value.length > 17) {
                          return "Password must be less than 18 character.";
                        }
                        if (!regex.hasMatch(value)) {
                          return "Password must be contains at least one upper case, lower case, digit and special charater";
                        }
                        if(value.trim() != account['password']) return "Password not match";
                      },
                      controller: password_controller,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      focusNode: focus,
                      decoration: const InputDecoration(
                        hintText: ' Password',
                        fillColor: Color(0xffACB1C0),
                        filled: true,
                        enabledBorder: OutlineInputBorder(),
                        errorMaxLines: 2,
                        contentPadding: EdgeInsets.all(5.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 29.0),
                    child: RaisedButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        _formKey.currentState.validate()
                            ? _setLogged(context, logindata, username_controller)
                            : Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('Not valid!')));
                      },
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                            color: Color(0xff007AFF),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: SizedBox.expand(
                          child: FlatButton(
                            onPressed: null,
                            child: new Text(
                              "SIGN IN",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "Forgot your password",
              style: TextStyle(
                fontSize: 20.0,
              ),
            )
          ],
        ),
      ),
    );
  }

  Expanded _logoSection() {
    return Expanded(
      child: Container(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 43.0,
                width: 43.0,
                child: Image(image: AssetImage("assets/images/ic_logo.png")),
              ),
              Text(" sentinel",
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontSize: 40.0,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
