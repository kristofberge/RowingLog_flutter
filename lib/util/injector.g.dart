// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// InjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  void configure() {
    final Container container = Container();
    container.registerFactory((c) => Container.scoped());
    container.registerSingleton((c) => Client());
    container.registerSingleton<StravaApi, StravaApiImpl>((c) => StravaApiImpl(
        c<Client>(), c<CurrentUserProvider>(), c<MapperContainer>()));
    container.registerSingleton((c) => StravaBloc(
        c<StravaApi>(), c<MapperContainer>(), c<CurrentUserProvider>()));
    container.registerSingleton((c) => ActivitiesBloc(
        c<StravaApi>(), c<MapperContainer>(), c<LocalStorage>()));
    container.registerSingleton((c) => MapperContainer(c<Container>()));
    container.registerSingleton((c) => LocalStorage());
    container.registerSingleton((c) => CurrentUserProvider(c<LocalStorage>()));
  }
}
