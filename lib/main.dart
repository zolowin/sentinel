import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sentinel/core/database/app_database.dart';

import 'package:sentinel/ui/login/login_page.dart';
import 'package:sentinel/ui/site/site_list.dart';
import 'package:sentinel/ui/site/add_site_page.dart';
import 'package:sentinel/ui/site/site_detail.dart';
import 'package:sentinel/ui/site/add_barn_page.dart';

import 'helpers/routers.dart';
import 'ui/login/login_page.dart';
import 'ui/site/site_detail.dart';
import 'ui/site/site_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final db= AppDatabase();
    return MultiProvider(
      providers: [
        Provider(create: (_) => db.barnDao),
        Provider(create: (_) => db.siteDao),
      ],
      child:MaterialApp(
        onGenerateRoute: Routers.generateRoute,
        initialRoute: Routers.LOGIN,
      ),
    );
  }
}
