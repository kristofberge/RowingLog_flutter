import 'package:meta/meta.dart';
import 'package:rowing_log/models/strava_user.dart';

@immutable
abstract class StravaState {}
  
class InitialStravaState extends StravaState {}

class StravaNotLoggedInState extends StravaState {}

class StravaLoggedInState extends StravaState {
  final StravaUser user;
  

  StravaLoggedInState(this.user);
}
