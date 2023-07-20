import 'package:equatable/equatable.dart';
import 'package:sezon/src/managers/shared_preferences_manager.dart';

class Category extends Equatable {
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

  // get name according to current language.
  get name =>
      SharedPreferencesManager.instance.getAppLang() == 'en' ? nameEn : nameAr;

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        nameEn,
        nameAr,
        image,
      ];
}
