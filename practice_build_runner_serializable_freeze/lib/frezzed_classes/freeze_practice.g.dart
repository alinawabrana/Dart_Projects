// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freeze_practice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InfoObjectFreezed _$InfoObjectFreezedFromJson(Map<String, dynamic> json) =>
    _InfoObjectFreezed(
      id: json['id'] as String,
      name: json['name'] as String,
      data: DataFreezed.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InfoObjectFreezedToJson(_InfoObjectFreezed instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'data': instance.data,
    };

_DataFreezed _$DataFreezedFromJson(Map<String, dynamic> json) => _DataFreezed(
  year: (json['year'] as num).toInt(),
  price: (json['price'] as num).toDouble(),
  cpuModel: json['CPU model'] as String,
  hardDiskSize: json['Hard disk size'] as String,
);

Map<String, dynamic> _$DataFreezedToJson(_DataFreezed instance) =>
    <String, dynamic>{
      'year': instance.year,
      'price': instance.price,
      'CPU model': instance.cpuModel,
      'Hard disk size': instance.hardDiskSize,
    };
