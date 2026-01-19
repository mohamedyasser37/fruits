/// id : "cus_TnvzphY3JDWTc1"
/// type : "customer"

class AssociatedObjects {
  AssociatedObjects({
      String? id, 
      String? type,}){
    _id = id;
    _type = type;
}

  AssociatedObjects.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
  }
  String? _id;
  String? _type;
AssociatedObjects copyWith({  String? id,
  String? type,
}) => AssociatedObjects(  id: id ?? _id,
  type: type ?? _type,
);
  String? get id => _id;
  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    return map;
  }

}