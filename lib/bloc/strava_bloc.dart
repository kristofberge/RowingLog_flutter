import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:rowing_log/models/strava_user.dart';
import 'package:rowing_log/providers/current_user_provider.dart';
import 'package:rowing_log/repositories/api/strava_api.dart';
import 'package:rowing_log/util/mappers/mapper_container.dart';
import './bloc.dart';

class StravaBloc extends Bloc<StravaEvent, StravaState> {
  final StravaApi _stravaApi;
  final MapperContainer _mapper;
  final CurrentUserProvider _userProvider;

  StravaBloc(this._stravaApi, this._mapper, this._userProvider);

  @override
  StravaState get initialState => InitialStravaState();

  @override
  Stream<StravaState> mapEventToState(
    StravaEvent event,
  ) async* {
    if (event is StravaPageOpenedEvent) {
      await _userProvider.initialize();

      if (_userProvider.currentStravaUser == null) {
        yield StravaNotLoggedInState();
      } else {
        yield StravaLoggedInState(_userProvider.currentStravaUser);
      }
    }

    else if (event is StravaCodeReceivedEvent) {
      var authResponse = await this._stravaApi.authenticate(event.code);
      var stravaUser = this._mapper.mapFromDynamicMap<StravaUser>(authResponse);
      yield StravaLoggedInState(stravaUser);
      await _userProvider.setStravaUser(stravaUser);
    }
  }
}
