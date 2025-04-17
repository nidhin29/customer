class Service {
  int? id;
  double? rate;
  String? items;
  String? description;
  String? imageUrl;
  String? companyName;

  Service({
    this.id,
    this.rate,
    this.items,
    this.description,
    this.imageUrl,
    this.companyName,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json['id'] as int?,
    rate: json['rate'] as double?,
    items: json['items'] as String?,
    description: json['description'] as String?,
    imageUrl: json['image_url'] as String?,
    companyName: json['Company Name'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'rate': rate,
    'items': items,
    'description': description,
    'image_url': imageUrl,
    'Company Name': companyName,
  };
}
