class DurasiTur {
  int? id;
  String? tour;
  int? days;
  int? cost;
  DurasiTur({this.id, this.tour, this.days, this.cost});
  factory DurasiTur.fromJson(Map<String, dynamic> obj) {
    return DurasiTur(
        id: obj['id'],
        tour: obj['tour'],
        days: obj['days'],
        cost: obj['cost']);
  }
}
