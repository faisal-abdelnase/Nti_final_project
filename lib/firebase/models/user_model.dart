class UserModel {
  String name;
  String uId;
  String email;
  String password;
  String imagePath;
  List<dynamic> frinds;

  UserModel({
    required this.name,
    required this.uId,
    required this.email,
    required this.password,
    required this.imagePath,
    required this.frinds,
  });

  // object =>  to json
  Map<String, dynamic> toJason() {
    return {
      'name': name,
      'uId': uId,
      'email': email,
      'password': password,
      'imagePath': imagePath,
      'frinds': frinds,
    };
  }

  // from json => object
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      uId: json['uId'],
      email: json['email'],
      password: json['password'],
      imagePath: json['imagePath'],
      frinds: json['frinds'],
      );
  }
}
