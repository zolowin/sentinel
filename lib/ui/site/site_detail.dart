import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'site_list.dart';
import 'add_site_page.dart';
import '../../core/database/app_database.dart';
import '../../core/database/dao/barn_dao.dart';

class SiteDetail extends StatefulWidget {
  static const routeName = '/siteDetail';
  @override
  _SiteDetailState createState() => _SiteDetailState();
}

class _SiteDetailState extends State<SiteDetail> {

  Widget _buildSiteImage(base64) {
    Uint8List _bytesImage;

    _bytesImage = Base64Decoder().convert(base64);
    return Image.memory(_bytesImage);
  }

  @override
  Widget build(BuildContext context) {
    final ScreenArguments arguments = ModalRoute.of(context).settings.arguments;

    Widget _buildListItem(Barn itemBarn) {
      return GestureDetector(
        child: Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Image(
                      image: AssetImage(
                          'assets/images/NHF-finishinghogsatfeeder.png')),
                ),
                Expanded(
                  flex: 8,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10.5),
                        child: ListTile(
                          title: Text(
                            itemBarn.name ?? "",
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle:
                          Text("Updated: SAT, JUN ${itemBarn.id} 7:30 PM"),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        padding:
                        EdgeInsets.fromLTRB(25, 10.0, 0, 15.0),
                        child: Text.rich(
                          TextSpan(
                            text: 'COUNT ',
                            style: TextStyle(fontSize: 14.0),
                            children: <TextSpan>[
                              TextSpan(
                                  text: itemBarn.quantity.toString(),
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
                icon: Icon(Icons.keyboard_arrow_right),
                iconSize: 35.0,
                onPressed: () {
                  print("this barn has been pressed");
                },
              ),
            )
          ],
        ),
        onTap: () {
          print("this barn has been tapped");
        },
      );
    }



    StreamBuilder<List<Barn>> _buildBarnList(BuildContext context, id)  {
      final dao = Provider.of<BarnDao>(context);
      return StreamBuilder(
        stream: dao.watchAllBarnsBySiteId(id),
        builder: (context, AsyncSnapshot<List<Barn>> snapshot) {
          final barns = snapshot.data ?? List();
          print('id ${id}');
          print(' barns ${barns}');
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Color(0xffD8D8D8),
            ),
            itemCount: barns.length,
            // ignore: missing_return
            itemBuilder: (context, index) {
              final itemBarn = barns[index];
              return _buildListItem(itemBarn);
            },
          );
        },
      );
    }

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                _buildSiteImage(arguments.image),
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 25.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconTheme(
                            data: IconThemeData(color: Colors.white),
                            child: GestureDetector(
                              child: Icon(
                                Icons.chevron_left,
                                size: 50.0,
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, SiteList.routeName);
                              },
                            ),
                          ),
                          IconTheme(
                            data: new IconThemeData(color: Colors.white),
                            child: new Icon(
                              Icons.more_vert,
                              size: 50.0,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 10.0),
                        width: double.maxFinite,
                        child: ListTile(
                          title: Text(
                            arguments.name ?? "",
                            style: TextStyle(
                                fontSize: 28.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            "Updated: Mar ${arguments.id}, 2020 9:51 PM",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 33.0,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10.0),
                        width: double.maxFinite,
                        child: ListTile(
                          title: Text(
                            arguments.quantity.toString(),
                            style: TextStyle(
                                fontSize: 24.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            "Total Count",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Flexible(
              child: _buildBarnList(context, arguments.id),
            ),
          ],
        ),
      ),
    );
  }
}
