import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:sentinel/core/database/table/sites.dart';

import '../app_database.dart';

part 'site_dao.g.dart';

@UseDao(tables : [Sites])
class SiteDao extends DatabaseAccessor<AppDatabase> with _$SiteDaoMixin {
  final AppDatabase db;

  SiteDao(this.db) : super(db);

  Future<List<Site>> getAllSites() => (select(sites)
    ..orderBy(
        [(c) => OrderingTerm(expression: c.id, mode:  OrderingMode.desc)]))
      .get();

  Future<Site> getSiteById(int id) =>
      (select(sites)..where((t) => t.id.equals(id))).getSingle();

  Stream<List<Site>> watchAllSites() => (select(sites)
    ..orderBy(
        [(c) => OrderingTerm(expression: c.id, mode: OrderingMode.desc)]))
      .watch();

  Stream<Site> watchSiteById(int id) => (select(sites)..where((t) => t.id.equals(id))).watchSingle();


  Future insertSite(Site site) => into(sites).insert(site, orReplace: true);

  Future updateSite(Site site) => update(sites).replace(site);

  Future deleteSite(Site site) => delete(sites).delete(site);

  Future deleteSiteById(int id) => (delete(sites)..where((c) => c.id.equals(id))).go();

  Future deleteAll() => delete(sites).go();
}