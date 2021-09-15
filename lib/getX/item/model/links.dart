class Links {
  String first;
  String last;
  dynamic prev;
  String next;

  Links({this.first, this.last, this.prev, this.next});

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json['first'] as String,
        last: json['last'] as String,
        prev: json['prev'] as dynamic,
        next: json['next'] as String,
      );

  Map<String, dynamic> toJson() => {
        'first': first,
        'last': last,
        'prev': prev,
        'next': next,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Links &&
        other.first == first &&
        other.last == last &&
        other.prev == prev &&
        other.next == next;
  }

  @override
  int get hashCode =>
      first.hashCode ^ last.hashCode ^ prev.hashCode ^ next.hashCode;
}
