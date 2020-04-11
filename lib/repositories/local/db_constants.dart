mixin DbConstants {
  // Database file
  static const String databaseFileName = 'rowing_log.db';

  // Tables
  static const String tableStravaUser = 'stravaUser';
  static const String tableStravaActivities = 'stravaActivities';

  // Columns
  static const String columnId = 'id';
  static const String columnUpdated = 'updated';
  static const String columnStravaId = 'stravaId';
  static const String columnUserName = 'userName';
  static const String columnFirstName = 'firstName';
  static const String columnLastName = 'lastName';
  static const String columnAccessToken = 'accessToken';
  static const String columnRefreshToken = 'refreshToken';
  static const String columnCity = 'city';
  static const String columnState = 'state';
  static const String columnCountry = 'country';
  static const String columnSex = 'sex';
  static const String columnHasPremium = 'hasPremium';
  static const String columnHasSummit = 'hasSummit';
  static const String columnAvatar = 'avatar';
  static const String columnName = 'name';
  static const String columnStartTime = 'startTime';
  static const String columnType = 'type';
  static const String columnDistance = 'distance';
  static const String columnMovingTime = 'movingTime';
  static const String columnAverageSpeed = 'averageSpeed';

  static const List<String> stravaUserColumns = [
    columnId,
    columnStravaId,
    columnUserName,
    columnFirstName,
    columnLastName,
    columnAccessToken,
    columnRefreshToken,
    columnCity,
    columnState,
    columnCountry,
    columnSex,
    columnHasPremium,
    columnHasSummit,
    columnAvatar
  ];

  static const List<String> stravaActivitiesColumns = [
    columnId,
    columnStravaId,
    columnName,
    columnStartTime,
    columnType,
    columnDistance,
    columnMovingTime,
    columnAverageSpeed
  ];
}
