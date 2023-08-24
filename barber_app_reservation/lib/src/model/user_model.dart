sealed class UserModel {
  final int id;
  final String name;
  final String email;
  final String? avatar;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
  });
}

class UserModelADM extends UserModel {
  final List<String>? workDays;
  final List<int>? workHours;
  UserModelADM({
    required super.id,
    required super.name,
    required super.email,
    super.avatar,
    this.workDays,
    this.workHours,
  });

  factory UserModelADM.fromMap(Map<String, dynamic> json) {
    // nova forma de implementar o from map com dart 3 com destruturacao
    return switch (json) {
      // patter matching para os dados obrigatórios vantagem com validação de dados
      {
        'id': final int id,
        'name': final String name,
        'email': final String email,
      } =>
        UserModelADM(
            id: id,
            name: name,
            email: email,
            avatar: json['avatar'],
            workDays: json['work_days']?.cast<String>(),
            workHours: json['work_hours']?.cast<int>()),
      _ => throw ArgumentError('Invalid Json'),
    };
  }
}

class UserModeEmployee extends UserModel {
  final int barbershopId;
  final List<String> workDays;
  final List<int> workHours;

  UserModeEmployee({
    required super.id,
    required super.name,
    required super.email,
    required this.barbershopId,
    required this.workDays,
    required this.workHours,
    super.avatar,
  });

  factory UserModeEmployee.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': final int id,
        'name': final String name,
        'email': final String email,
        'barbershop_id': final int barbershopId,
        'work_days': final List<String> workDays,
        'work_hours': final List<int> workHours,
      } =>
        UserModeEmployee(
          id: id,
          name: name,
          email: email,
          avatar: json['avatar'],
          barbershopId: barbershopId,
          workDays: workDays,
          workHours: workHours,
        ),
      _ => throw ArgumentError('Invalid Json'),
    };
  }
}
