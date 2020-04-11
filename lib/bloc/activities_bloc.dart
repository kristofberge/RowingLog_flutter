import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:rowing_log/models/strava_activity.dart';
import 'package:rowing_log/repositories/api/strava_api.dart';
import 'package:rowing_log/repositories/local/local_storage.dart';
import 'package:rowing_log/util/mappers/mapper_container.dart';
import './bloc.dart';

class ActivitiesBloc extends Bloc<ActivitiesEvent, ActivitiesState> {
  final StravaApi _api;
  final MapperContainer _mapper;
  final LocalStorage _localStorage;

  ActivitiesBloc(this._api, this._mapper, this._localStorage);

  @override
  ActivitiesState get initialState => InitialActivitiesState();

  @override
  Stream<ActivitiesState> mapEventToState(ActivitiesEvent event) async* {
    if (event is ActivitiesListDisplayed) {
      var localActivities = await _localStorage.getStravaActivities();
      if (localActivities != null) {
        yield FirstPageLoadedState(localActivities);
      }

      var maps = await _api.getActivities(1);
      Iterable<StravaActivity> activities = maps.map<StravaActivity>((act) => _mapper.mapFromDynamicMap<StravaActivity>(act));

      if (_hasNewActivities(localActivities, activities)) {
        yield FirstPageLoadedState(activities);
        await _localStorage.storeActivities(activities);
      }
    }
  }

  bool _hasNewActivities(Iterable<StravaActivity> localActivities, Iterable<StravaActivity> activities) {
    bool newActivityFound = localActivities.length != activities.length;
    int i = 0;
    while (!newActivityFound && i < activities)
  }
}
