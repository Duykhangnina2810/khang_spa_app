// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AuthUserModel _$$_AuthUserModelFromJson(Map<String, dynamic> json) =>
    _$_AuthUserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      status: json['status'] as String,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      avatar: json['avatar'] as String?,
      birthday: json['birthday'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      fullName: json['fullName'] as String?,
      gender: json['gender'] as String?,
      phone: json['phone'] as String?,
      flagAvatar: json['flagAvatar'] as bool?,
    );

Map<String, dynamic> _$$_AuthUserModelToJson(_$_AuthUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'avatar': instance.avatar,
      'birthday': instance.birthday,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'fullName': instance.fullName,
      'gender': instance.gender,
      'phone': instance.phone,
      'flagAvatar': instance.flagAvatar,
    };
