
class Garden {
  int id;
  String name;
  String description;
  String fotoBase64;
  String updatedBy;
  DateTime lastupdated;

  Map<String, dynamic> toJson() => {
        'id': id,
        'wie': name,
        'wat': description,
        'fotoBase64':fotoBase64,
        'aanmelder': updatedBy,
        'lastupdated': lastupdated,
      };
}
