import 'package:moor_flutter/moor_flutter.dart';
import 'package:sentinel/core/database/dao/site_dao.dart';
import 'package:sentinel/core/database/dao/barn_dao.dart';
import 'package:sentinel/core/database/table/sites.dart';
import 'package:sentinel/core/database/table/barns.dart';

part 'app_database.g.dart';

@UseMoor(
  tables: [Sites, Barns],
  daos: [SiteDao, BarnDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(path: "db.sqlite"));
  static AppDatabase _instance;

  static AppDatabase instance() {
    if(_instance == null) _instance = AppDatabase();
    return _instance;
  }

  @override
  int get schemaVersion => 5;


  Future<void> clearData() async {
    await siteDao.deleteAll();
    await barnDao.deleteAll();
  }
}

class BarnWithSite {
  final Barn barn;
  final Site site;

  BarnWithSite({
    @required this.barn,
    @required this.site,
  });
}