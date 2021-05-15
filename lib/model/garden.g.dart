// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garden.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Garden _$GardenFromJson(Map<String, dynamic> json) {
  return Garden()
    ..id = json['id'] as int
    ..name = json['name'] as String
    ..lat = (json['lat'] as num).toDouble()
    ..lng = (json['lng'] as num).toDouble()
    ..description = json['description'] as String
    ..fotoBase64 = json['fotoBase64'] as String?
    ..updatedBy = json['updatedBy'] as String?
    ..lastupdated = json['lastupdated'] == null
        ? null
        : DateTime.parse(json['lastupdated'] as String)
    ..notes = (json['notes'] as List<dynamic>)
        .map((e) => Note.fromJson(e as Map<String, dynamic>))
        .toList()
    ..photos = (json['photos'] as List<dynamic>)
        .map((e) => Photo.fromJson(e as Map<String, dynamic>))
        .toList()
    ..type = _$enumDecode(_$GardenTypeEnumMap, json['type']);
}

Map<String, dynamic> _$GardenToJson(Garden instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lat': instance.lat,
      'lng': instance.lng,
      'description': instance.description,
      'fotoBase64': instance.fotoBase64,
      'updatedBy': instance.updatedBy,
      'lastupdated': instance.lastupdated?.toIso8601String(),
      'notes': instance.notes.map((e) => e.toJson()).toList(),
      'photos': instance.photos.map((e) => e.toJson()).toList(),
      'type': _$GardenTypeEnumMap[instance.type],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$GardenTypeEnumMap = {
  GardenType.VT: 'VT',
  GardenType.NB: 'NB',
};

Note _$NoteFromJson(Map<String, dynamic> json) {
  return Note()
    ..note = json['note'] as String
    ..updatedBy = json['updatedBy'] as String
    ..lastupdated = json['lastupdated'] == null
        ? null
        : DateTime.parse(json['lastupdated'] as String);
}

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'note': instance.note,
      'updatedBy': instance.updatedBy,
      'lastupdated': instance.lastupdated?.toIso8601String(),
    };

Photo _$PhotoFromJson(Map<String, dynamic> json) {
  return Photo()
    ..fotoBase64 = json['fotoBase64'] as String?
    ..updatedBy = json['updatedBy'] as String?
    ..lastupdated = json['lastupdated'] == null
        ? null
        : DateTime.parse(json['lastupdated'] as String);
}

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'fotoBase64': instance.fotoBase64,
      'updatedBy': instance.updatedBy,
      'lastupdated': instance.lastupdated?.toIso8601String(),
    };
