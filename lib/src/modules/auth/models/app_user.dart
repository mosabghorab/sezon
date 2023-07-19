import 'dart:convert';

AppUser appUserFromStringJson(String stringJson) =>
    AppUser.fromJson(json.decode(stringJson));

String appUserToStringJson(AppUser appUser) => json.encode(appUser.toJson());

class AppUser {
  String? uid;
  String? name;
  String? phone;

  AppUser({
    this.uid,
    required this.name,
    required this.phone,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        uid: json['uid'],
        name: json['name'],
        phone: json['phone'],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "phone": phone,
      };
}
