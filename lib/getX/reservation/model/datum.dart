class Datum {
  int id;
  int userId;
  String userName;
  int deviceId;
  int siteTypeId;
  int campId;
  int partnerId;
  String startDate;
  String endDate;
  int price;
  int adultNumber;
  int childrenNumber;
  String status;
  String campName;
  String siteTypeName;
  String deviceName;
  String imgUrl;
  String createdAt;
  String updatedAt;

  Datum({
    this.id,
    this.userId,
    this.userName,
    this.deviceId,
    this.siteTypeId,
    this.campId,
    this.partnerId,
    this.startDate,
    this.endDate,
    this.price,
    this.adultNumber,
    this.childrenNumber,
    this.status,
    this.campName,
    this.siteTypeName,
    this.deviceName,
    this.imgUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int,
        userId: json['user_id'] as int,
        userName: json['user_name'] as String,
        deviceId: json['device_id'] as int,
        siteTypeId: json['site_type_id'] as int,
        campId: json['camp_id'] as int,
        partnerId: json['partner_id'] as int,
        startDate: json['start_date'] as String,
        endDate: json['end_date'] as String,
        price: json['price'] as int,
        adultNumber: json['adult_number'] as int,
        childrenNumber: json['children_number'] as int,
        status: json['status'] as String,
        campName: json['camp_name'] as String,
        siteTypeName: json['site_type_name'] as String,
        deviceName: json['device_name'] as String,
        imgUrl: json['img_url'] as String,
        createdAt: json['created_at'] as String,
        updatedAt: json['updated_at'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'user_name': userName,
        'device_id': deviceId,
        'site_type_id': siteTypeId,
        'camp_id': campId,
        'partner_id': partnerId,
        'start_date': startDate,
        'end_date': endDate,
        'price': price,
        'adult_number': adultNumber,
        'children_number': childrenNumber,
        'status': status,
        'camp_name': campName,
        'site_type_name': siteTypeName,
        'device_name': deviceName,
        'img_url': imgUrl,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Datum &&
        other.id == id &&
        other.userId == userId &&
        other.userName == userName &&
        other.deviceId == deviceId &&
        other.siteTypeId == siteTypeId &&
        other.campId == campId &&
        other.partnerId == partnerId &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.price == price &&
        other.adultNumber == adultNumber &&
        other.childrenNumber == childrenNumber &&
        other.status == status &&
        other.campName == campName &&
        other.siteTypeName == siteTypeName &&
        other.deviceName == deviceName &&
        other.imgUrl == imgUrl &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      userId.hashCode ^
      userName.hashCode ^
      deviceId.hashCode ^
      siteTypeId.hashCode ^
      campId.hashCode ^
      partnerId.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      price.hashCode ^
      adultNumber.hashCode ^
      childrenNumber.hashCode ^
      status.hashCode ^
      campName.hashCode ^
      siteTypeName.hashCode ^
      deviceName.hashCode ^
      imgUrl.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
