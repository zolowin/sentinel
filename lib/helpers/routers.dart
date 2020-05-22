import 'package:flutter/material.dart';
import '../ui/login/login_page.dart';
import '../ui/site/add_barn_page.dart';
import '../ui/site/add_site_page.dart';
import '../ui/site/site_detail.dart';
import '../ui/site/site_list.dart';

class Routers {
  static const String DETAIL = "/siteDetail";
  static const String LIST = "/siteList";
  static const String LOGIN = "/loginPage";
  static const String ADD_SITE = "/addSite";
  static const String ADD_BARN = "/addBarn";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    var arguments = settings.arguments;
    var argumentSite = arguments as ScreenArguments;

    switch (settings.name) {
      case LOGIN:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case DETAIL:
        return MaterialPageRoute(builder: (_) => SiteDetail(argumentSite));
      case LIST:
        return MaterialPageRoute(builder: (_) => SiteList());
      case ADD_SITE:
        return MaterialPageRoute(builder: (_) => AddSite(argumentSite));
      case ADD_BARN:
        return MaterialPageRoute(builder: (_) => AddBarn(argumentSite));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
