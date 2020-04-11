import 'package:rowing_log/common/enums.dart';
import 'package:rowing_log/models/strava_activity.dart';
import 'package:rowing_log/models/strava_user.dart';

import 'db_constants.dart';

mixin DbHelper {
  StravaUser getUserFromMap(Map<String, dynamic> map) {
    return StravaUser(
      stravaId: map[DbConstants.columnStravaId],
      accessToken: map[DbConstants.columnAccessToken],
      refreshToken: map[DbConstants.columnRefreshToken],
      userName: map[DbConstants.columnUserName],
      firstName: map[DbConstants.columnFirstName],
      lastName: map[DbConstants.columnLastName],
      city: map[DbConstants.columnCity],
      state: map[DbConstants.columnState],
      country: map[DbConstants.columnCountry],
      sex: _getSexFromDbValue(map[DbConstants.columnSex]),
      hasPremium: _getBoolFromDbValue(map[DbConstants.columnHasPremium]),
      hasSummit: _getBoolFromDbValue(map[DbConstants.columnHasSummit]),
      avatar: map[DbConstants.columnAvatar],
      dbId: map[DbConstants.columnId],
    );
  }

  Map<String, dynamic> getMapFromUser(StravaUser user) {
    return {
      DbConstants.columnStravaId: user.stravaId,
      DbConstants.columnAccessToken: user.accessToken,
      DbConstants.columnRefreshToken: user.refreshToken,
      DbConstants.columnUserName: user.userName,
      DbConstants.columnFirstName: user.firstName,
      DbConstants.columnLastName: user.lastName,
      DbConstants.columnCity: user.city,
      DbConstants.columnState: user.state,
      DbConstants.columnCountry: user.country,
      DbConstants.columnSex: _getDbValueFromSex(user.sex),
      DbConstants.columnHasPremium: _getDbValueFromBool(user.hasPremium),
      DbConstants.columnHasSummit: _getDbValueFromBool(user.hasSummit),
      DbConstants.columnAvatar: user.avatar
    };
  }

  StravaActivity getActivityFromMap(Map<String, dynamic> map) {
    return StravaActivity(
      stravaId: map[DbConstants.columnStravaId],
      name: map[DbConstants.columnName],
      type: _getActivityTypeFromDbValue(map[DbConstants.columnType]),
      startTime: DateTime.parse(map[DbConstants.columnStartTime]),
      movingTime: Duration(seconds: map[DbConstants.columnMovingTime]),
      distance: map[DbConstants.columnDistance],
      averageSpeed: map[DbConstants.columnAverageSpeed],
      dbId: map[DbConstants.columnId]
    );
  }

  Map<String, dynamic> getMapFromActivity(StravaActivity activity) {
    return {
      DbConstants.columnStravaId: activity.stravaId,
      DbConstants.columnName: activity.name,
      DbConstants.columnType: _getDbValueFromActivityType(activity.type),
      DbConstants.columnStartTime: activity.startTime.toIso8601String(),
      DbConstants.columnMovingTime: activity.movingTime.inSeconds,
      DbConstants.columnDistance: activity.distance,
      DbConstants.columnAverageSpeed: activity.averageSpeed,
    };
  }

  int _getDbValueFromSex(Sex sex) {
    switch (sex) {
      case Sex.female:
        {
          return 0;
        }
      case Sex.male:
        {
          return 1;
        }
      default:
        {
          return 2;
        }
    }
  }

  Sex _getSexFromDbValue(int i) {
    switch (i) {
      case 0:
        {
          return Sex.female;
        }
      case 1:
        {
          return Sex.male;
        }
      default:
        {
          return Sex.other;
        }
    }
  }

  int _getDbValueFromBool(bool b) => b ? 1 : 0;

  bool _getBoolFromDbValue(int i) => i == 0 ? false : true;

  int _getDbValueFromActivityType(ActivityType type) {
      switch (type) {
        case ActivityType.IndoorRowing:
          return 0;
        case ActivityType.WaterRowing:
          return 1;
        case ActivityType.RoadCycling:
          return 2;
        case ActivityType.IndoorCycling:
          return 3;
        case ActivityType.SkiErg:
          return 4;
        case ActivityType.Run:
          return 5;
        case ActivityType.Walk:
          return 6;
        case ActivityType.Hike:
          return 7;
        case ActivityType.Workout:
          return 8;
        case ActivityType.Swim:
          return 9;
      }
  }

  ActivityType _getActivityTypeFromDbValue(int i) {
    switch (i) {
      case 0:
        return ActivityType.IndoorRowing;
      case 1:
        return ActivityType.WaterRowing;
      case 2:
        return ActivityType.RoadCycling;
      case 3:
        return ActivityType.IndoorCycling;
      case 4:
        return ActivityType.SkiErg;
      case 5:
        return ActivityType.Run;
      case 6:
        return ActivityType.Walk;
      case 7:
        return ActivityType.Hike;
      case 8:
        return ActivityType.Workout;
      case 9:
        return ActivityType.Swim;
      default:
        return ActivityType.Workout;
    }
  }
}
