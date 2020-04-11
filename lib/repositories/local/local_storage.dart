import 'package:rowing_log/models/strava_activity.dart';
import 'package:rowing_log/models/strava_user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import 'db_constants.dart';
import 'db_helper.dart';

class LocalStorage with DbHelper {
  Database _db;

  Future<void> initialize() async {
    _db = await openDatabase(
      DbConstants.databaseFileName,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
create table ${DbConstants.tableStravaUser} ( 
  ${DbConstants.columnId} integer primary key autoincrement, 
  ${DbConstants.columnStravaId} integer not null,
  ${DbConstants.columnUserName} text not null,
  ${DbConstants.columnFirstName} text not null,
  ${DbConstants.columnLastName} text not null,
  ${DbConstants.columnAccessToken} text not null,
  ${DbConstants.columnRefreshToken} text not null,
  ${DbConstants.columnCity} text,
  ${DbConstants.columnState} text,
  ${DbConstants.columnCountry} text,
  ${DbConstants.columnSex} integer,
  ${DbConstants.columnHasPremium} integer,
  ${DbConstants.columnHasSummit} integer,
  ${DbConstants.columnAvatar} text
  )
''');
        await db.execute('''
create table ${DbConstants.tableStravaActivities} (
  ${DbConstants.columnId} integer primary key autoincrement,
  ${DbConstants.columnStravaId} integer not null,
  ${DbConstants.columnName} text not null,
  ${DbConstants.columnType} integer not null,
  ${DbConstants.columnStartTime} text not null,
  ${DbConstants.columnDistance} real,
  ${DbConstants.columnMovingTime} integer,
  ${DbConstants.columnAverageSpeed} real
  )
''');
      },
    );
  }

  Future deleteStravaUser(String id) async {
    await _db.delete(DbConstants.tableStravaUser, where: '${DbConstants.columnId} = ?', whereArgs: [id]);
  }

  Future storeStravaUser(StravaUser user) async {
    List<Map> maps = await _db.query(DbConstants.tableStravaUser, columns: [DbConstants.columnId]);
    if (maps.length == 0) {
      await _db.insert(DbConstants.tableStravaUser, getMapFromUser(user));
    } else {
      await _db.update(DbConstants.tableStravaUser, getMapFromUser(user));
    }
  }

  Future<StravaUser> getStravaUser() async {
    List<Map> maps = await _db.query(DbConstants.tableStravaUser, columns: DbConstants.stravaUserColumns);
    if (maps.length > 0) {
      return getUserFromMap(maps.first);
    }
    return null;
  }

  Future storeActivities(Iterable<StravaActivity> activities) async {
    Iterable<Map<String, dynamic>> maps = activities.map((a) => getMapFromActivity(a));
    var batch = _db.batch();
    batch.delete(DbConstants.tableStravaActivities);
    maps.forEach((map) => batch.insert(DbConstants.tableStravaActivities, map));
    await batch.commit();
  }

  Future<Iterable<StravaActivity>> getStravaActivities() async {
    Iterable<Map<String, dynamic>> maps = await _db.query(DbConstants.tableStravaActivities, columns: DbConstants.stravaActivitiesColumns);
    if (maps.length > 0) {
      return maps.map((map) => getActivityFromMap(map));
    }

    return null;
  }
}
