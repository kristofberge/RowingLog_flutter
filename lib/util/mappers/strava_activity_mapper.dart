import 'package:rowing_log/common/enums.dart';
import 'package:rowing_log/util/mappers/mapper_container.dart';
import 'package:rowing_log/models/strava_activity.dart';

class StravaActivityMapper implements Mapper<Map<String, dynamic>, StravaActivity> {
  @override
  StravaActivity map(Map<String, dynamic> from) {
    try {
      var activityType = _getActivityType(from['type']);
      return StravaActivity(
        stravaId: from['id'],
        name: from['name'],
        type: activityType,
        distance: from['distance'],
        averageSpeed: from['average_speed'],
        startTime: DateTime.parse(from['start_date_local']), // TODO set correct value
        movingTime: Duration(seconds: from['moving_time']),
      );
    } on Exception catch (_) {
      return null;
    }
  }

  ActivityType _getActivityType(String type) {
    switch (type.toLowerCase()) {
      case 'hike':
        return ActivityType.Hike;
      case 'ride':
        return ActivityType.RoadCycling;
      case 'rowing':
        return ActivityType.WaterRowing;
      case 'run':
        return ActivityType.Run;
      case 'swim':
        return ActivityType.Swim;
      case 'walk':
        return ActivityType.Walk;
      default:
        return ActivityType.Workout;
    }
  }

  double _getSplit(ActivityType activityType) {

  }

  String _getSplitUnit(ActivityType activityType) {

  }
}
