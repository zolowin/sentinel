import 'package:moor_flutter/moor_flutter.dart';

class Sites extends Table {
  IntColumn get id => integer().autoIncrement().nullable()();

  TextColumn get name => text().nullable()();

  TextColumn get address => text().nullable()();

  IntColumn get quantity => integer().nullable()();

  TextColumn get image => text().nullable()();

  DateTimeColumn get update => dateTime().nullable()();
}