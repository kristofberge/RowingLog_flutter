import 'package:http/http.dart';
import 'package:kiwi/kiwi.dart';
import 'package:rowing_log/bloc/activities_bloc.dart';
import 'package:rowing_log/bloc/strava_bloc.dart';
import 'package:rowing_log/providers/current_user_provider.dart';
import 'package:rowing_log/repositories/api/strava_api.dart';
import 'package:rowing_log/repositories/local/local_storage.dart';
import 'package:rowing_log/util/mappers/mapper_container.dart';

part 'injector.g.dart';

abstract class Injector {
  @Register.factory(Container, constructorName: 'scoped')
  @Register.singleton(Client)
  @Register.singleton(StravaApi, from: StravaApiImpl)
  @Register.singleton(StravaBloc)
  @Register.singleton(ActivitiesBloc)
  @Register.singleton(MapperContainer)
  @Register.singleton(LocalStorage)
  @Register.singleton(CurrentUserProvider)
  void configure();

  static Injector get injector => _$Injector();
}