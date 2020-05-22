import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:sentinel/core/database/dao/site_dao.dart';
import 'package:sentinel/helpers/routers.dart';

import 'add_site_page.dart';
import '../../core/database/app_database.dart';
import '../../core/database/dao/barn_dao.dart';

class SiteDetail extends StatefulWidget {
//  static const routeName = '/siteDetail';
  final ScreenArguments arguments;
  SiteDetail(this.arguments);
  @override
  _SiteDetailState createState() => _SiteDetailState();
}

class _SiteDetailState extends State<SiteDetail> {
  @override
  // TODO: implement context
  BuildContext get context => super.context;

  var formatter = new DateFormat('E, MMM dd hh-mm-ss');

  _editOrDeleteSite (BuildContext context,value,id) {
    final barnDao = Provider.of<BarnDao>(context, listen: false);
    final siteDao = Provider.of<SiteDao>(context, listen: false);
    switch (value) {
      case 1 :
          barnDao.deleteBarnBySiteId(id);
          siteDao.deleteSiteById(id);
          return Navigator.pushNamed(context, Routers.LIST);
      case 2 :
        return print('khỏi sửa');
    }
  }

  Widget _buildSiteImage(base64) {
    Uint8List _bytesImage;

    _bytesImage = Base64Decoder().convert(base64);
    return Image.memory(
      _bytesImage,
      fit: BoxFit.fill,
    );
  }

  @override
  Widget build(BuildContext context) {
    final dao = Provider.of<BarnDao>(context);
//    final ScreenArguments arguments = ModalRoute.of(context).settings.arguments;

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
                          subtitle: Text(
                              "Updated at: ${formatter.format(itemBarn.update)}"),
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

    StreamBuilder<List<Barn>> _buildBarnList(BuildContext context, id) {
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
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 340.0,
                  child: this.widget.arguments.image != null
                      ? _buildSiteImage(this.widget.arguments.image)
                      : Container(),
                ),
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
                                size: 35.0,
                              ),
                              onTap: () =>
                                  Navigator.pushNamed(context, Routers.LIST),
                            ),
                          ),
                          PopupMenuButton<int>(
                            onSelected: (int result) {
                              setState(() {
                                _editOrDeleteSite(context, result ,this.widget.arguments.id);
                              });
                            },
                            icon: Icon(Icons.more_vert, color: Colors.white,),
                            itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<int>>[
                              const PopupMenuItem<int>(
                                value: 1,
                                child: Icon(Icons.delete),
                              ),
                              const PopupMenuItem<int>(
                                value: 2,
                                child: Icon(Icons.edit),
                              ),
                            ],
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
                            this.widget.arguments.name ?? "",
                            style: TextStyle(
                                fontSize: 28.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            "Updated at: ${formatter.format(this.widget.arguments.update)}",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 27.0,
                      ),
                      FutureBuilder(
                        future: dao.getCountPoBarnBySiteID(this.widget.arguments.id),
                        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                          Widget children;
                          if(snapshot.hasData) {
                            children = Text(
                              snapshot.data,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            children = Text(snapshot.error);
                          } else {
                            children = Text('Awaiting result...');
                          }
                          return Container(
                            padding: EdgeInsets.only(left: 10.0),
                            width: double.maxFinite,
                            child: ListTile(
                              title: children,
                              subtitle: Text(
                                "Total Count",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                    ],
                  ),
                ),
              ],
            ),
            Flexible(
              child: _buildBarnList(context, this.widget.arguments.id),
            ),
          ],
        ),
      ),
    );

  }
}
