import 'dart:core';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:rowing_log/common/enums.dart';
import 'package:rowing_log/models/storable.dart';
import 'package:rowing_log/repositories/local/local_storage.dart';

class StravaUser extends Equatable implements Storable {
  StravaUser(
      {@required this.stravaId,
      this.accessToken,
      this.refreshToken,
      this.userName,
      this.firstName,
      this.lastName,
      this.city,
      this.state,
      this.country,
      this.sex,
      this.hasPremium,
      this.hasSummit,
      this.avatar,
      int dbId}) {
        this._id = dbId;
      }

  final int stravaId;
  final String accessToken;
  final String refreshToken;
  final String userName;
  final String firstName;
  final String lastName;
  final String city;
  final String state;
  final String country;
  final Sex sex;
  final bool hasPremium;
  final bool hasSummit;
  final String avatar;

  int _id;

  @override
  List<Object> get props => [
        stravaId,
        accessToken,
        refreshToken,
        userName,
        firstName,
        lastName,
        city,
        state,
        country,
        sex,
        hasPremium,
        hasSummit,
        avatar,
        _id
      ];

  @override
  int get id => _id;
}
