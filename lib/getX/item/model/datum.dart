class Datum {
  int id;
  int campId;
  int partnerId;
  int price;
  String name;
  int quantity;
  String description;
  String imgUrl;
  String createdAt;
  String updatedAt;

  Datum({
    this.id,
    this.campId,
    this.partnerId,
    this.price,
    this.name,
    this.quantity,
    this.description,
    this.imgUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int,
        campId: json['camp_id'] as int,
        partnerId: json['partner_id'] as int,
        price: json['price'] as int,
        name: json['name'] as String,
        quantity: json['quantity'] as int,
        description: json['description'] as String,
        imgUrl: json['img_url'] as String,
        createdAt: json['created_at'] as String,
        updatedAt: json['updated_at'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'camp_id': campId,
        'partner_id': partnerId,
        'price': price,
        'name': name,
        'quantity': quantity,
        'description': description,
        'img_url': imgUrl,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Datum &&
        other.id == id &&
        other.campId == campId &&
        other.partnerId == partnerId &&
        other.price == price &&
        other.name == name &&
        other.quantity == quantity &&
        other.description == description &&
        other.imgUrl == imgUrl &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      campId.hashCode ^
      partnerId.hashCode ^
      price.hashCode ^
      name.hashCode ^
      quantity.hashCode ^
      description.hashCode ^
      imgUrl.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
