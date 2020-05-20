import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../site/add_site_page.dart';
import 'package:provider/provider.dart';

import '../../core/database/app_database.dart';
import '../../core/database/dao/barn_dao.dart';
import 'site_list.dart';

class AddBarn extends StatefulWidget {
  static const routeName = '/addBarn';

  const AddBarn({
    Key key,
  }) : super(key: key);

  @override
  _AddBarnState createState() => _AddBarnState();
}

class _AddBarnState extends State<AddBarn> {

  final _formKey = GlobalKey<FormState>();
  final _labelStyle = TextStyle(
    color: Color(0xffACB1C0),
  );

  var focusNodes  = [];
  var namesController = [];
  var quantityController = [];

  @override
  Widget build(BuildContext context) {
    final  ScreenArguments arguments = ModalRoute.of(context).settings.arguments;
    for(int i=0; i < arguments.quantity* 2; i += 1) {
      focusNodes.add(FocusNode());
    }

    for(int i = 0; i < arguments.quantity; i += 1) {
      namesController.add(TextEditingController());
      quantityController.add(TextEditingController());
    }

    Widget _buildRow(index) {
      var i = index * 2;
      var j = i + 1;
      var id = index + 1;

      return Padding(
        padding: EdgeInsets.only(bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: TextFormField(
                // ignore: missing_return
                validator: (value){
                  if(value.isEmpty) {
                    return "Barn Name can't empty";
                  }
                },
                controller: namesController[index],
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: index != arguments.quantity ? TextInputAction.next : TextInputAction.done,
                autofocus: true,
                focusNode: focusNodes[i], //0
                onFieldSubmitted: (v){
                  index != arguments.quantity ?
                  FocusScope.of(context).requestFocus(focusNodes[j])  //1
                  // ignore: unnecessary_statements
                      : null;
                },
                decoration: InputDecoration(
                  labelText: "Barn $id Name",
                  labelStyle: _labelStyle,
                ),
              ),
            ),
            SizedBox(width: 50.0,),
            Flexible(
              child: TextFormField(
                // ignore: missing_return
                validator: (value){
                  Pattern pattern = r'^[0-9]{1,3}$';
                  RegExp regex = new RegExp(pattern);
                  if(value.isEmpty) {
                    return "Number of Pens can't empty";
                  }
                  if(!regex.hasMatch(value)) {
                    return "Number must only contain digit with max value is 999";
                  }
                },
                controller: quantityController[index],
                keyboardType: TextInputType.number,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
                autofocus: true,
                focusNode: focusNodes[j], //1
                onFieldSubmitted: (v){
                  FocusScope.of(context).requestFocus(focusNodes[j+1]); //2
                },
                decoration: InputDecoration(
                  labelText: "Number of Pens",
                  labelStyle: _labelStyle,
                  errorMaxLines: 2,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        leading: IconButton(
            icon: Icon(Icons.chevron_left),
            color: Colors.black,
            iconSize: 30.0,
            onPressed: () {
              editSite(arguments);
            }),
        title: Text("${arguments.name} Site", style: TextStyle(color: Colors.black),),
        centerTitle: true,
        actions: <Widget>[

          GestureDetector(
            child: Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Center(
                child: Text(
                  "Done",
                  style: TextStyle(
                    fontSize: 21.0,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffFF2D55),
                  ),
                ),
              ),
            ),
            onTap: () {
              _formKey.currentState.validate() ?
              createNewBarn(context, _formKey, namesController, quantityController, arguments.id)
                  : Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('Not valid!')));
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 16, 0, 0),
        height: double.maxFinite,
        width: double.maxFinite,
        child: Form(
            key: _formKey,
            child: ListView.builder(
              itemCount: int.parse(arguments.quantity.toString()),
              itemBuilder: (context, index) {
                return _buildRow(index);
              },
            )
        ),
      ),
    );
  }

  void editSite(arguments) {
    final site = Site (
        id: arguments.id,
        name: arguments.name,
        address: arguments.address,
        quantity: arguments.quantity
    );

    Navigator.pushNamed(
      context,
      AddSite.routeName,
      arguments: BackScreenArguments(site.id, site.name, site.address, site.quantity),
    );
    print(site.id);
  }

  void createNewBarn(BuildContext context, key, namesControllers, quantityController, siteId) {
    key.currentState.save();

    final dao = Provider.of<BarnDao>(context, listen: false);

    for( var i = 0; i < namesControllers.length; i++ ) {
      var barn = Barn(
        name: namesControllers[i].text,
        quantity: int.parse(quantityController[i].text),
        site_id: siteId,
        update: new DateTime.now(),
      );
      print(barn.quantity);
      dao.insertBarn(barn);
    }
    Navigator.pushNamed(
      context,
      SiteList.routeName,
    );
  }

  void resetValuesAfterSubmit() {
    setState(() {
      namesController.clear();
      quantityController.clear();
    });
  }

}

class BackScreenArguments {
  final int id;
  final String name;
  final String address;
  final int quantity;

  BackScreenArguments(this.id, this.name, this.address, this.quantity);
}
