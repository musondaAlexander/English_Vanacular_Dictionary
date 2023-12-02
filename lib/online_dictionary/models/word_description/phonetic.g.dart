// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phonetic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Phonetic _$PhoneticFromJson(Map<String, dynamic> json) => Phonetic(
      audio: json['audio'] as String?,
      sourceUrl: json['sourceUrl'] as String?,
      license: json['license'] == null
          ? null
          : License.fromJson(json['license'] as Map<String, dynamic>),
      text: json['text'] as String?,
    );

Map<String, dynamic> _$PhoneticToJson(Phonetic instance) => <String, dynamic>{
      'audio': instance.audio,
      'sourceUrl': instance.sourceUrl,
      'license': instance.license,
      'text': instance.text,
    };
