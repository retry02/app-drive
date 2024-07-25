import 'package:indriver_clone_flutter/src/domain/models/Role.dart';

class User {
    int? id;
    String name;
    String lastname;
    String? email;
    String phone;
    String? password;
    String? image;
    String? notificationToken;
    DateTime? createdAt;
    DateTime? updatedAt;
    List<Role>? roles;

    User({
        this.id,
        required this.name,
        required this.lastname,
        this.email,
        required this.phone,
        this.image,
        this.password,
        this.notificationToken,
        this.createdAt,
        this.updatedAt,
        this.roles,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        phone: json["phone"],
        image: json["image"],
        password: json['password'],
        notificationToken: json["notification_token"],
        roles: json["roles"] != null ? List<Role>.from(json["roles"].map((x) => Role.fromJson(x))) : [],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastname": lastname,
        "email": email,
        "phone": phone,
        "image": image,
        'password': password,
        "notification_token": notificationToken,
        "roles": roles != null ? List<dynamic>.from(roles!.map((x) => x.toJson())) : [],
    };
}