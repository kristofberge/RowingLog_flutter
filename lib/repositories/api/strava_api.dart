import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rowing_log/common/constants.dart';
import 'package:rowing_log/models/strava_user.dart';
import 'package:rowing_log/providers/current_user_provider.dart';
import 'package:rowing_log/repositories/exceptions/api_exception.dart';
import 'package:rowing_log/util/mappers/mapper_container.dart';

abstract class StravaApi {
  Future<Map<String, dynamic>> authenticate(String code);
  Future<List<Map<String, dynamic>>> getActivities(int page);
}

class StravaApiImpl extends StravaApi {
  static const String _stravaBaseUrl = 'www.strava.com';
  static const String _authPath = 'oauth/token';
  static const String _v3Api = 'api/v3';
  static const String _activitiesPath = '$_v3Api/athlete/activities';

  final http.Client _client;
  final CurrentUserProvider _userProvider;
  final MapperContainer _mapper;

  StravaApiImpl(this._client, this._userProvider, this._mapper);

  @override
  Future<Map<String, dynamic>> authenticate(String code) async {
    var url = Uri.https(_stravaBaseUrl, _authPath, {
      'client_id': Constants.stravaClientId,
      'client_secret': Constants.stravaClientSecret,
      'code': code,
      'grant_type': 'authorization_code',
    });
    var response = await this._client.post(url);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    }

    throw ApiException();
  }

  @override
  Future<List<Map<String, dynamic>>> getActivities(int page) async {
    return await _performAuthenticatedCall(() async {
      var url = Uri.https(_stravaBaseUrl, _activitiesPath, {'page': '$page'});
      var response = await _client.get(url, headers: {'Authorization': 'Bearer ${_userProvider.currentStravaUser.accessToken}'});

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> dynamicList = json.decode(response.body);
        return dynamicList.cast<Map<String, dynamic>>();
      }
      if (response.statusCode == 401) {
        throw UnauthorizedException();
      }

      throw ApiException();
    });
  }

  Future<T> _performAuthenticatedCall<T>(Future<T> Function() call) async {
    try {
      return await call();
    } on UnauthorizedException catch (_) {
      await _refreshToken();
      return await call();
    }
  }

  Future _refreshToken() async {
    var url = Uri.https(_stravaBaseUrl, _authPath, {
      'client_id': Constants.stravaClientId,
      'client_secret': Constants.stravaClientSecret,
      'refresh_token': _userProvider.currentStravaUser.refreshToken,
      'grant_type': 'refresh_token',
    });
    var response = await _client.post(url);

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> body = json.decode(response.body);
      await _updateStravaUser(_userProvider.currentStravaUser, body['access_token'], body['refresh_token']);
    }
  }

  Future _updateStravaUser(StravaUser old, String accessToken, String refreshToken) async {
    var newUser = StravaUser(
      stravaId: old.stravaId,
      accessToken: accessToken,
      refreshToken: refreshToken,
      userName: old.userName,
      firstName: old.firstName,
      lastName: old.lastName,
      country: old.country,
      state: old.state,
      city: old.city,
      sex: old.sex,
      hasSummit: old.hasSummit,
      hasPremium: old.hasPremium,
      avatar: old.avatar
    );
    await _userProvider.setStravaUser(newUser);
  }
}
