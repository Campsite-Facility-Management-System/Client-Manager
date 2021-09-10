class JsonCategoryList {
  int id;
  int campsiteId;
  String name;
  String description;
  int price;
  int maxCarNum;
  int maxAdultNum;
  int maxChildrenNum;
  int maxEnergy;
  String createdAt;
  String updatedAt;
  String imgUrl;

  JsonCategoryList({
    this.id,
    this.campsiteId,
    this.name,
    this.description,
    this.price,
    this.maxCarNum,
    this.maxAdultNum,
    this.maxChildrenNum,
    this.maxEnergy,
    this.createdAt,
    this.updatedAt,
    this.imgUrl,
  });

  factory JsonCategoryList.fromJson(Map<String, dynamic> json) =>
      JsonCategoryList(
        id: json['id'] as int,
        campsiteId: json['campsite_id'] as int,
        name: json['name'] as String,
        description: json['description'] as String,
        price: json['price'] as int,
        maxCarNum: json['max_car_num'] as int,
        maxAdultNum: json['max_adult_num'] as int,
        maxChildrenNum: json['max_children_num'] as int,
        maxEnergy: json['max_energy'] as int,
        createdAt: json['created_at'] as String,
        updatedAt: json['updated_at'] as String,
        imgUrl: json['img_url'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'campsite_id': campsiteId,
        'name': name,
        'description': description,
        'price': price,
        'max_car_num': maxCarNum,
        'max_adult_num': maxAdultNum,
        'max_children_num': maxChildrenNum,
        'max_energy': maxEnergy,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'img_url': imgUrl,
      };
}
