class OrderAddress {
  String? id;
  String? country;
  String? city;
  String? region;
  String? street;
  String? zipCode;

  OrderAddress({
    required this.country,
    required this.city,
    required this.region,
    required this.street,
    required this.zipCode,
  });

  factory OrderAddress.fromJson(Map<String, dynamic> json) => OrderAddress(
        country: json['country'],
        city: json['city'],
        region: json['region'],
        street: json['street'],
        zipCode: json['zipCode'],
      );

  Map<String, dynamic> toJson() => {
        'country': country,
        'city': city,
        'region': region,
        'street': street,
        'zipCode': zipCode,
      };
}
