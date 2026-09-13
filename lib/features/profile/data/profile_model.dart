class ProfileModel {
  final String name;
  final String email;

  ProfileModel({required this.name, required this.email});

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email};
  }

  factory ProfileModel.fromMap(Map<dynamic, dynamic> map) {
    return ProfileModel(name: map['name'], email: map['email']);
  }
}
