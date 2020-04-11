import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:rowing_log/models/strava_activity.dart';
import 'package:rowing_log/models/strava_user.dart';
import 'package:rowing_log/util/mappers/strava_activity_mapper.dart';
import 'package:rowing_log/util/mappers/strava_user_mapper.dart';

class MapperContainer {
  final kiwi.Container _container;
  MapperContainer(this._container) {
    this._container.registerSingleton<Mapper<Map<String, dynamic>, StravaUser>, StravaUserMapper>((c) => StravaUserMapper());
    this._container.registerSingleton<Mapper<Map<String, dynamic>, StravaActivity> ,StravaActivityMapper>((c) => StravaActivityMapper());
  }

  TTo map<TFrom, TTo>(TFrom from) => this._container.resolve<Mapper<TFrom, TTo>>().map(from);
  T mapFromDynamicMap<T>(Map<String, dynamic> fromMap) => map<Map<String, dynamic>, T>(fromMap);
}

abstract class Mapper<TFrom, TTo> {
  TTo map(TFrom from);
}