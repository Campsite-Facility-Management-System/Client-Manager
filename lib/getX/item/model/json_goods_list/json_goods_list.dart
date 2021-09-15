import 'package:flutter/foundation.dart';

import 'datum.dart';
import 'links.dart';
import 'meta.dart';

class JsonGoodsList {
  List<Datum> data;
  Links links;
  Meta meta;

  JsonGoodsList({this.data, this.links, this.meta});

  factory JsonGoodsList.fromJson(Map<String, dynamic> json) => JsonGoodsList(
        data: (json['data'] as List<dynamic>)
            .map((e) => Datum.fromJson(e as Map<String, dynamic>))
            .toList(),
        links: json['links'] == null
            ? null
            : Links.fromJson(json['links'] as Map<String, dynamic>),
        meta: json['meta'] == null
            ? null
            : Meta.fromJson(json['meta'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'data': data.map((e) => e.toJson()).toList(),
        'links': links.toJson(),
        'meta': meta.toJson(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is JsonGoodsList &&
        other.links == links &&
        other.meta == meta &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => data.hashCode ^ links.hashCode ^ meta.hashCode;
}
