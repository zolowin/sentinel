import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sentinel/ui/site/add_site_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:typed_data';

import '../../core/database/dao/site_dao.dart';
import '../login/login_page.dart';
import 'site_detail.dart';
import '../../core/database/app_database.dart';
import '../login/login_page.dart';

class SiteList extends StatefulWidget {
  static const routeName = '/siteList';
  @override
  _SiteListState createState() => _SiteListState();
}

class _SiteListState extends State<SiteList> {
  SharedPreferences logindata;
  String username;
  String _base64;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username');
    });
  }

  Widget _buildSiteImage(base64) {
    Uint8List _bytesImage;

    _bytesImage = Base64Decoder().convert(base64);
    return Image.memory(_bytesImage);
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildListItem(Site itemSite) {
      return GestureDetector(
        child: Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: _buildSiteImage(itemSite.image),
                ),
                Expanded(
                  flex: 8,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10.5),
                        child: ListTile(
                          title: Text(
                            itemSite.name,
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text("Updated: SAT, JUN ${itemSite.id} 7:30 PM"),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.fromLTRB(25, 10.0, 0, 15.0),
                        child: Text.rich(
                          TextSpan(
                            text: 'COUNT ',
                            style: TextStyle(fontSize: 14.0),
                            children: <TextSpan>[
                              TextSpan(
                                  text: itemSite.quantity.toString(),
                                  style: TextStyle(
                                    color: Colors.lightBlue,
                                  )),
                              // can add more TextSpans here...
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 32,
              right: 0,
              child: IconButton(
                icon: Icon(Icons.keyboard_arrow_right), iconSize: 35.0,
                onPressed: () {
                  Navigator.pushNamed(context, SiteDetail.routeName, arguments: ScreenArguments(itemSite.id, itemSite.name, itemSite.address, itemSite.quantity, itemSite.image));
                },
              ),
            )
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, SiteDetail.routeName, arguments: ScreenArguments(itemSite.id, itemSite.name, itemSite.address, itemSite.quantity, itemSite.image));
        },
      );
    }

    StreamBuilder<List<Site>> _buildSiteList(BuildContext context) {
      final dao = Provider.of<SiteDao>(context);
      return StreamBuilder(
        stream: dao.watchAllSites(),
        builder: (context, AsyncSnapshot<List<Site>> snapshot) {
          final sites = snapshot.data ?? List();

          return ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Color(0xffD8D8D8),
            ),
            itemCount: sites.length,
            // ignore: missing_return
            itemBuilder: (_, index) {
              final itemSite = sites[index];
              return _buildListItem(itemSite);
            },
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Text("My Sites", style: TextStyle(color: Colors.black),), centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AddSite.routeName);
            },
            child: Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Center(
                child: Text(
                  "Add Site",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffFF2D55),
                  ),
                ),
              ),
            )
          )
        ],
      ),
      drawer: Drawer(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 50.0,
                        width: 50.0,
                        child: Image(image: AssetImage('assets/images/ic_logo.png')),
                      ),
                      Text(
                        'sentinel',
                        style: TextStyle(
                          fontSize: 32.0,
                          color: Color(0xff1E2432),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 8.5, 0, 40.0),
                  child: Text(
                    'Version 0.0.3',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Color(0xffACB1C0)
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    "Logged in as",
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    username,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
                bottom: 40.0,
                left: 15.0,
                child: GestureDetector(
                  child: Text(
                    "Sign Out",
                    style: TextStyle(
                        color: Color(0xffFF2D55),
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                  onTap: () {
                    logindata.setBool('login', true);
                    Navigator.pushNamed(context, LoginPage.routeName);
                  },
                )
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 0, 0),
        child:_buildSiteList(context),
      )
    );
  }
}
