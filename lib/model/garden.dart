class Garden {
  late int id;
  late String name;
  late String description;
  late String fotoBase64;
  late String updatedBy;
  late DateTime lastupdated;

  Map<String, dynamic> toJson() => {
        'id': id,
        'wie': name,
        'wat': description,
        'fotoBase64': fotoBase64,
        'aanmelder': updatedBy,
        'lastupdated': lastupdated,
      };
}
