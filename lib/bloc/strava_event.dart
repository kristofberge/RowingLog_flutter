import 'package:meta/meta.dart';

@immutable
abstract class StravaEvent {}

class StravaPageOpenedEvent extends StravaEvent {}

class StravaLoggedInEvent extends StravaEvent {}

class StravaCodeReceivedEvent extends StravaEvent {
  final String code;

  StravaCodeReceivedEvent(this.code);
}