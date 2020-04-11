import 'package:equatable/equatable.dart';

abstract class ActivitiesEvent extends Equatable {
  const ActivitiesEvent();
}

class ActivitiesListDisplayed extends ActivitiesEvent {
  @override
  List<Object> get props => [];
}
