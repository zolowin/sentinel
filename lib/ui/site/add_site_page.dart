import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:io' as Io;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sentinel/core/database/app_database.dart';
import 'package:sentinel/core/database/dao/site_dao.dart';
import 'package:sentinel/ui/site/add_barn_page.dart';

class AddSite extends StatefulWidget {
  static const routeName = '/addSite';

  const AddSite({
    Key key,
  }) : super(key: key);

  @override
  _AddSiteState createState() => _AddSiteState();
}

class _AddSiteState extends State<AddSite> {
  final _formKey = GlobalKey<FormState>();
  final _labelStyle = TextStyle(
    color: Color(0xffACB1C0),
  );
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  String siteImage ;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  Io.File _image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    nameController = TextEditingController();
    addressController = TextEditingController();
    quantityController = TextEditingController();
  }

   open_camera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
    List<int> imageBytes = await image.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    print(base64Image.substring(0, 100));
    return base64Image;
  }

  open_gallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    List<int> imageBytes = await image.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    print(base64Image.substring(0, 100));
    return base64Image;
  }

  @override
  Widget build(BuildContext context) {
    final BackScreenArguments args = ModalRoute.of(context).settings.arguments;
    args != null
        ? nameController = TextEditingController(text: args.name)
        : TextEditingController();
    args != null
        ? addressController = TextEditingController(text: args.address)
        : TextEditingController();
    args != null
        ? quantityController =
            TextEditingController(text: args.quantity.toString())
        : TextEditingController();

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Text(
          "Add New Site",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Center(
                child: Text(
                  "Next",
                  style: TextStyle(
                    fontSize: 21.0,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffFF2D55),
                  ),
                ),
              ),
            ),
            onTap: () {
              _formKey.currentState.validate()
                  ?
                  // ignore: unnecessary_statements
                  (args != null
                      ? editSite(context, _formKey, args.id, nameController,
                          addressController, quantityController)
                      : createNewSite(context, _formKey, nameController,
                          addressController, quantityController, siteImage))
                  : Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Not valid!')));
            },
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            padding: EdgeInsets.fromLTRB(30, 12, 0, 0),
            child: Column(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        // ignore: missing_return
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Size Name can't empty";
                          }
                        },
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.next,
                        autofocus: true,
                        onFieldSubmitted: (v) {
                          FocusScope.of(context).requestFocus(focus1);
                        },
                        decoration: InputDecoration(
                          labelText: "Size Name",
                          labelStyle: _labelStyle,
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        // ignore: missing_return
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Site Address can't empty";
                          }
                        },
                        controller: addressController,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.next,
                        autofocus: true,
                        focusNode: focus1,
                        onFieldSubmitted: (v) {
                          FocusScope.of(context).requestFocus(focus2);
                        },
                        decoration: InputDecoration(
                            labelText: "Site Address", labelStyle: _labelStyle),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        // ignore: missing_return
                        validator: (value) {
                          Pattern pattern = r'^[0-9]{1,3}$';
                          RegExp regex = new RegExp(pattern);
                          if (value.isEmpty) {
                            return "Number of Barns can't empty";
                          }
                          if (!regex.hasMatch(value)) {
                            return "Number must only contain digit with max value is 999";
                          }
                        },
                        controller: quantityController,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.done,
                        focusNode: focus2,
                        decoration: InputDecoration(
                          labelText: "Number of Barns",
                          labelStyle: _labelStyle,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 15.0,),
                Container(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        color: Colors.black12,
                        height: 250.0,
                        width: 250.0,
                        child: _image == null
                            ? Text("Still waiting!")
                            : Image.file(_image , fit: BoxFit.cover,),
                      ),
                      FlatButton(
                        color: Colors.deepOrangeAccent,
                        child: Text(
                          "Open Camera",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          siteImage = await open_camera();
                        },
                      ),
                      FlatButton(
                        color: Colors.limeAccent,
                        child: Text(
                          "Open Gallery",
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () async {
                          siteImage = await open_gallery();
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> createNewSite(BuildContext context, key, nameController,
      addressController, quantityController, siteImage) async {
    key.currentState.save();

    final dao = Provider.of<SiteDao>(context, listen: false);

    final site = Site(
      name: nameController.text,
      address: addressController.text,
      quantity: int.parse(quantityController.text),
      image : siteImage,
    );
    var id = await dao.insertSite(site);
    resetValuesAfterSubmit();
    Navigator.pushNamed(
      context,
      AddBarn.routeName,
      arguments: ScreenArguments(id, site.name, site.address, site.quantity, site.image),
    );
  }

  void editSite(BuildContext context, key, id, nameController,
      addressController, quantityController) {
    key.currentState.save();

    final dao = Provider.of<SiteDao>(context, listen: false);

    final site = Site(
      id: id,
      name: nameController.text,
      address: addressController.text,
      quantity: int.parse(quantityController.text),
    );
    print('edit');
    dao.updateSite(site);
    resetValuesAfterSubmit();
    Navigator.pushNamed(
      context,
      AddBarn.routeName,
      arguments:
          ScreenArguments(site.id, site.name, site.address, site.quantity, site.image),
    );
  }

  void resetValuesAfterSubmit() {
    setState(() {
      nameController.clear();
      addressController.clear();
      quantityController.clear();
    });
  }
}

class ScreenArguments {
  final int id;
  final String name;
  final String address;
  final int quantity;
  final String image;

  ScreenArguments(this.id, this.name, this.address, this.quantity, this.image);
}
