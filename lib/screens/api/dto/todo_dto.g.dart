// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoDTO _$TodoDTOFromJson(Map<String, dynamic> json) => TodoDTO(
      json['complete'] as bool,
      json['id'] as String,
      json['userIdToken'] as String,
      json['note'] as String,
      json['title'] as String?,
      (json['todos'] as List<dynamic>)
          .map((e) => TodoDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TodoDTOToJson(TodoDTO instance) => <String, dynamic>{
      'complete': instance.complete,
      'id': instance.id,
      'userIdToken': instance.userIdToken,
      'note': instance.note,
      'title': instance.title,
      'todos': instance.todos,
    };
