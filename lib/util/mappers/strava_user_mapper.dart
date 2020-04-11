import 'package:rowing_log/common/enums.dart';
import 'package:rowing_log/models/strava_user.dart';
import 'package:rowing_log/util/mappers/mapper_container.dart';

class StravaUserMapper implements Mapper<Map<String, dynamic>, StravaUser> {
  @override
  StravaUser map(Map<String, dynamic> from) {
    Map<String, dynamic> athlete = from['athlete'];
    return StravaUser(
      stravaId: athlete['id'],
      accessToken: from['access_token'],
      refreshToken: from['refresh_token'],
      userName: athlete['username'],
      firstName: athlete['firstname'],
      lastName: athlete['lastname'],
      sex: athlete['sex'] == 'M' ? Sex.male : Sex.female,
      city: athlete['city'],
      state: athlete['state'],
      country: athlete['country'],
      avatar: athlete['profile'],
      hasPremium: athlete['premium'],
      hasSummit: athlete['summit']
    );
  }
}
