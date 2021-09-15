class Link {
  dynamic url;
  String label;
  bool active;

  Link({this.url, this.label, this.active});

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json['url'] as dynamic,
        label: json['label'] as String,
        active: json['active'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'url': url,
        'label': label,
        'active': active,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Link &&
        other.url == url &&
        other.label == label &&
        other.active == active;
  }

  @override
  int get hashCode => url.hashCode ^ label.hashCode ^ active.hashCode;
}
