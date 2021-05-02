import 'package:json_annotation/json_annotation.dart';

part 'garden.g.dart';

@JsonSerializable()
class Garden {
  int id = 0;
  String name = '';
  late double lat;
  late double lng;
  String description = '';
  String? fotoBase64;
  String? updatedBy;
  DateTime? lastupdated;
  List<Note> notes = [];
  List<Photo> photos = [];

  Garden();
  Map<String, dynamic> toJson() => _$GardenToJson(this);
  factory Garden.fromJson(Map<String, dynamic> map) => _$GardenFromJson(map);
}

@JsonSerializable()
class Note {
  String note = '';
  String updatedBy = '';
  DateTime? lastupdated;

  Note();
  Map<String, dynamic> toJson() => _$NoteToJson(this);
  factory Note.fromJson(Map<String, dynamic> map) => _$NoteFromJson(map);
}

@JsonSerializable()
class Photo {
  String? fotoBase64;
  String? updatedBy;
  DateTime? lastupdated;

  Photo();
  Map<String, dynamic> toJson() => _$PhotoToJson(this);
  factory Photo.fromJson(Map<String, dynamic> map) => _$PhotoFromJson(map);
}
