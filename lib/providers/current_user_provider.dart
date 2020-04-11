import 'package:rowing_log/models/strava_user.dart';
import 'package:rowing_log/models/user.dart';
import 'package:rowing_log/repositories/local/local_storage.dart';

class CurrentUserProvider {
  final LocalStorage _localStorage;

  User _currentUser;

  CurrentUserProvider(this._localStorage);

  Future initialize() async {
    _currentUser = new User();
    await _localStorage.initialize();
    _currentUser.stravaUser = await _localStorage.getStravaUser();
  }

  Future setStravaUser(StravaUser stravaUser) async {
    _currentUser.stravaUser = stravaUser;
    await _localStorage.storeStravaUser(stravaUser);
  }

  User get currentUser {
    if (_currentUser == null) {
      throw new Exception('You need to call CurrentUserProvider.initialize() first.');
    }
    return _currentUser;
  }

  StravaUser get currentStravaUser => currentUser.stravaUser;
}