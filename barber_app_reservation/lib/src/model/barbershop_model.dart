class BarbershopModel {
  final int id;
  final String name;
  final String email;
  final List<String> openingDays;
  final List<int> openHours;
  BarbershopModel({
    required this.id,
    required this.name,
    required this.email,
    required this.openingDays,
    required this.openHours,
  });

  factory BarbershopModel.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': final int id,
        'name': final String name,
        'email': final String email,
        'opening_days': final List openingDays,
        'opening_hours': final List openHours,
      } =>
        BarbershopModel(
          id: id,
          name: name,
          email: email,
          openingDays: openingDays.cast<String>(),
          openHours: openHours.cast<int>(),
        ),
      _ => throw ArgumentError('Invalid Json')
    };
  }
}
