import 'package:flutter/foundation.dart';

class Test {
  int id;
  int campId;
  int partnerId;
  int price;
  int quantity;
  String name;
  String type;
  String description;
  String createdAt;
  String updatedAt;
  List<dynamic> imgUrl;

  Test({
    this.id,
    this.campId,
    this.partnerId,
    this.price,
    this.quantity,
    this.name,
    this.type,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.imgUrl,
  });

  factory Test.fromJson(Map<String, dynamic> json) => Test(
        id: json['id'] as int,
        campId: json['camp_id'] as int,
        partnerId: json['partner_id'] as int,
        price: json['price'] as int,
        quantity: json['quantity'] as int,
        name: json['name'] as String,
        type: json['type'] as String,
        description: json['description'] as String,
        createdAt: json['created_at'] as String,
        updatedAt: json['updated_at'] as String,
        imgUrl: json['img_url'] as List<dynamic>,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'camp_id': campId,
        'partner_id': partnerId,
        'price': price,
        'quantity': quantity,
        'name': name,
        'type': type,
        'description': description,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'img_url': imgUrl,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Test &&
        listEquals(other.imgUrl, imgUrl) &&
        other.id == id &&
        other.campId == campId &&
        other.partnerId == partnerId &&
        other.price == price &&
        other.quantity == quantity &&
        other.name == name &&
        other.type == type &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      campId.hashCode ^
      partnerId.hashCode ^
      price.hashCode ^
      quantity.hashCode ^
      name.hashCode ^
      type.hashCode ^
      description.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      imgUrl.hashCode;
}
