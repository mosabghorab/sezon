class Category {
  String? id;
  String? nameEn;
  String? nameAr;
  String? image;

  Category({
    required this.nameEn,
    required this.nameAr,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        nameEn: json['nameEn'],
        nameAr: json['nameAr'],
        image: json['image'],
      );
}
