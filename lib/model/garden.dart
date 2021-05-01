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

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'lat': lat,
        'lng': lng,
        'description': description,
        'fotoBase64': fotoBase64,
        'updatedBy': updatedBy,
        'lastupdated': lastupdated
        // 'notes'
      };
}

class Note {
  String note = '';
  String updatedBy = '';
  DateTime lastupdated = DateTime.now();
}

class Photo {
  String? fotoBase64;
  String? updatedBy;
  DateTime? lastupdated;
}
