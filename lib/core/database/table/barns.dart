import 'package:moor_flutter/moor_flutter.dart';

class Barns extends Table {
  IntColumn get id => integer().autoIncrement().nullable()();

  TextColumn get name => text().nullable()();

  IntColumn get quantity => integer().nullable()();

  IntColumn get site_id => integer().nullable().customConstraint('NULL REFERENCES sites(id)')();
}