import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:rowing_log/common/enums.dart';
import 'package:rowing_log/models/storable.dart';

class StravaActivity extends Equatable implements Storable {
  int _id;

  final int stravaId;
  final String name;
  final DateTime startTime;
  final ActivityType type;
  final double distance;
  final Duration movingTime;
  final double averageSpeed;

  StravaActivity({@required this.stravaId, this.name, this.startTime, this.type, this.distance, this.movingTime, this.averageSpeed, int dbId}) {
    _id = dbId;
  }

  @override
  int get id => _id;

  @override
  List<Object> get props => [this.stravaId, this.name, this.startTime, this.type, this.distance, this.movingTime, this.averageSpeed, _id];
}
