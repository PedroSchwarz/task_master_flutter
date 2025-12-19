// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credentials_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CredentialsData _$CredentialsDataFromJson(Map<String, dynamic> json) =>
    _CredentialsData(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$CredentialsDataToJson(_CredentialsData instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
