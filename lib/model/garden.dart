import 'package:json_annotation/json_annotation.dart';

part 'garden.g.dart';

@JsonSerializable(explicitToJson: true)
class Garden {
  int id = 0;
  String name = '';
  late double lat;
  late double lng;
  String description = '';
  String? fotoBase64;
  late String updatedBy;
  late DateTime lastupdated;
  List<Note> notes = [];
  List<Photo> photos = [];
  GardenType type = GardenType.VT; //default

  Garden();
  Map<String, dynamic> toJson() => _$GardenToJson(this);
  factory Garden.fromJson(Map<String, dynamic> map) => _$GardenFromJson(map);
}

@JsonSerializable(explicitToJson: true)
class Note {
  String note = '';
  String updatedBy = '';
  DateTime? lastupdated;

  Note();
  Map<String, dynamic> toJson() => _$NoteToJson(this);
  factory Note.fromJson(Map<String, dynamic> map) => _$NoteFromJson(map);
}

@JsonSerializable(explicitToJson: true)
class Photo {
  String? fotoBase64;
  String? updatedBy;
  DateTime? lastupdated;

  Photo();
  Map<String, dynamic> toJson() => _$PhotoToJson(this);
  factory Photo.fromJson(Map<String, dynamic> map) => _$PhotoFromJson(map);
}

enum GardenType {
  VT,
  NB,
}

extension GardenTypeExt on GardenType {
   String get name {
    switch (this) {
      case GardenType.VT:
        return 'Vlindertuin';
      case GardenType.NB:
        return 'Nieuw beheer';
      default:
        return '??';
    }
  }
}

List<GardenType> gardenTypes = [GardenType.VT, GardenType.NB];