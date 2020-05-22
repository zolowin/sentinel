import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:sentinel/core/database/table/barns.dart';

import '../app_database.dart';

part 'barn_dao.g.dart';

@UseDao(tables: [Barns])
class BarnDao extends DatabaseAccessor<AppDatabase> with _$BarnDaoMixin {
  final AppDatabase db;

  BarnDao(this.db) : super(db);

  Future<List<Barn>> getAllBarns() => (select(barns)
    ..orderBy(
        [(c) => OrderingTerm(expression: c.id, mode: OrderingMode.desc)]))
      .get();

  Future<List<Barn>> getAllBarnsBySiteId(int id) => (select(barns)
    ..where((t) => t.site_id.equals(id))).get();

  Future<Barn> getBarnById(int id) => (select(barns)
    ..where((t) => t.id.equals(id))).getSingle();

  Future<String> getCountPoBarnBySiteID(int id) async {
    int count = 0;
    List<Barn> barns = await getAllBarnsBySiteId(id);

    for(var item in barns) {
      count += item.quantity;
    }
    return count.toString();
  }

  Stream<List<Barn>> watchAllBarns() => (select(barns)
    ..orderBy(
        [(c) => OrderingTerm(expression: c.id, mode: OrderingMode.desc)]))
      .watch();

  Stream<List<Barn>> watchAllBarnsBySiteId(int id) => (select(barns)
    ..where((t) => t.site_id.equals(id))).watch();

  Stream<Barn> watchBarnById(int id) => (select(barns)
    ..where((t) => t.id.equals(id))).watchSingle();

  Future insertBarn(Barn barn) => into(barns).insert(barn);

  Future updateBarn(Barn barn) => update(barns).replace(barn);

  Future deleteBarn(Barn barn) => delete(barns).delete(barn);

  Future deleteBarnById(int id) => (delete(barns)
    ..where((t) => t.id.equals(id))).go();

  Future deleteBarnBySiteId(int id) => (delete(barns)
    ..where((t) => t.site_id.equals(id))).go();

  Future deleteAll() => delete(barns).go();
}