class AppUser {
  String? name;
  String? phone;

  AppUser({
    required this.name,
    required this.phone,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        name: json['name'],
        phone: json['phone'],
      );
}
