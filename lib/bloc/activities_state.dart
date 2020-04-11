import 'package:equatable/equatable.dart';
import 'package:rowing_log/models/strava_activity.dart';

abstract class ActivitiesState extends Equatable {
  const ActivitiesState();
}

class InitialActivitiesState extends ActivitiesState {
  @override
  List<Object> get props => [];
}

class FirstPageLoadedState extends ActivitiesState {
  final Iterable<StravaActivity> activities;

  FirstPageLoadedState(this.activities);

  @override
  List<Object> get props => [activities];
}
