// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScheduleModelImpl _$$ScheduleModelImplFromJson(Map<String, dynamic> json) =>
    _$ScheduleModelImpl(
      day: json['day'] as String,
      time: json['time'] as String,
      m1: json['m1'] as String,
      m2: json['m2'] as String,
      m3: json['m3'] as String,
      m4: json['m4'] as String,
      m5: json['m5'] as String,
      m6: json['m6'] as String,
      m7: json['m7'] as String,
      notification: json['notification'] as String,
    );

Map<String, dynamic> _$$ScheduleModelImplToJson(_$ScheduleModelImpl instance) =>
    <String, dynamic>{
      'day': instance.day,
      'time': instance.time,
      'm1': instance.m1,
      'm2': instance.m2,
      'm3': instance.m3,
      'm4': instance.m4,
      'm5': instance.m5,
      'm6': instance.m6,
      'm7': instance.m7,
      'notification': instance.notification,
    };
