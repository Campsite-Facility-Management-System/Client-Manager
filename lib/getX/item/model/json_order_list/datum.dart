class Datum {
  int id;
  int campId;
  int partnerId;
  String status;
  int totalPrice;
  String userNickname;
  int count;
  String imgUrl;
  String goodsName;
  dynamic deviceName;
  String createdAt;
  String updatedAt;

  Datum({
    this.id,
    this.campId,
    this.partnerId,
    this.status,
    this.totalPrice,
    this.userNickname,
    this.count,
    this.imgUrl,
    this.goodsName,
    this.deviceName,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int,
        campId: json['camp_id'] as int,
        partnerId: json['partner_id'] as int,
        status: json['status'] as String,
        totalPrice: json['total_price'] as int,
        userNickname: json['user_nickname'] as String,
        count: json['count'] as int,
        imgUrl: json['img_url'] as String,
        goodsName: json['goods_name'] as String,
        deviceName: json['device_name'] as dynamic,
        createdAt: json['created_at'] as String,
        updatedAt: json['updated_at'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'camp_id': campId,
        'partner_id': partnerId,
        'status': status,
        'total_price': totalPrice,
        'user_nickname': userNickname,
        'count': count,
        'img_url': imgUrl,
        'goods_name': goodsName,
        'device_name': deviceName,
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
        other.status == status &&
        other.totalPrice == totalPrice &&
        other.userNickname == userNickname &&
        other.count == count &&
        other.imgUrl == imgUrl &&
        other.goodsName == goodsName &&
        other.deviceName == deviceName &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      campId.hashCode ^
      partnerId.hashCode ^
      status.hashCode ^
      totalPrice.hashCode ^
      userNickname.hashCode ^
      count.hashCode ^
      imgUrl.hashCode ^
      goodsName.hashCode ^
      deviceName.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
