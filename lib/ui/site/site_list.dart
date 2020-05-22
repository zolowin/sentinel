import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sentinel/core/database/dao/barn_dao.dart';
import 'package:sentinel/helpers/routers.dart';
import 'package:sentinel/ui/site/add_site_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:intl/intl.dart';


import '../../core/database/dao/site_dao.dart';
import '../../core/database/app_database.dart';

class SiteList extends StatefulWidget {
  @override
  _SiteListState createState() => _SiteListState();
}

class _SiteListState extends State<SiteList> {
  SharedPreferences logindata;
  String username;
  int _textFromFile = 0;
  var formatter = new DateFormat('E, MMM dd hh-mm-ss');

  @override
  // TODO: implement context
  BuildContext get context => super.context;

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

  getPoBarns(BuildContext context, id) async{
    final dao = Provider.of<BarnDao>(context);
    final count = await dao.getCountPoBarnBySiteID(id);
    return count;
  }

  @override
  Widget build(BuildContext context) {
    final dao = Provider.of<BarnDao>(context);
      Widget _buildListItem(Site itemSite)  {
      return GestureDetector(
        child: Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: itemSite.image != null ? _buildSiteImage(itemSite.image) : Container(),
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
//                          subtitle: Text("Updated: SAT, JUN ${itemSite.id} 7:30 PM"),
                            subtitle: itemSite.update != null ? Text("Updated at: ${formatter.format(itemSite.update)}") : Text(""),
                        ),
                      ),
                      FutureBuilder(
                        future: dao.getCountPoBarnBySiteID(itemSite.id),
                        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                          Widget children;
                          if(snapshot.hasData) {
                            children = Text(
                              snapshot.data,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            children = Text(snapshot.error);
                          } else {
                            children = Text('Awaiting result...');
                          }
                          return Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.fromLTRB(25, 10.0, 0, 15.0),
                            child: Row(
                              children: <Widget>[
                                Text('Count', style: TextStyle(fontSize: 14.0),),
                                SizedBox(width: 10.0,),
                                children,
                              ],
                            ),
                          );
                        },
                      ),
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
                onPressed: () => Navigator.pushNamed(context, Routers.DETAIL, arguments: ScreenArguments(itemSite.id, itemSite.name, itemSite.address, itemSite.quantity, itemSite.image, itemSite.update)),
              ),
            )
          ],
        ),
        onTap: () => Navigator.pushNamed(context, Routers.DETAIL, arguments: ScreenArguments(itemSite.id, itemSite.name, itemSite.address, itemSite.quantity, itemSite.image, itemSite.update)),
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
            itemCount: sites.length ?? 0,
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
            onTap: () => Navigator.pushNamed(context, Routers.ADD_SITE),
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
                  subtitle: username != null ? Text(
                    username,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  )
                  : Text(""),
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
                    Navigator.pushNamed(context, Routers.LOGIN);
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
