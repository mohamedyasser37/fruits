import 'AssociatedObjects.dart';

/// id : "ephkey_1SqKN8JAdRlzIPvQbDr7KMTK"
/// object : "ephemeral_key"
/// associated_objects : [{"id":"cus_TnvzphY3JDWTc1","type":"customer"}]
/// created : 1768598158
/// expires : 1768601758
/// livemode : false
/// secret : "ek_test_YWNjdF8xU3BhQWRKQWRSbHpJUHZRLENwQ3IydlJNMHozR084RW5ORHhVY1BsOXBBVTlsSWo_009h7eKttP"

class EphemeralKey {
  EphemeralKey({
      String? id, 
      String? object, 
      List<AssociatedObjects>? associatedObjects, 
      int? created, 
      int? expires, 
      bool? livemode, 
      String? secret,}){
    _id = id;
    _object = object;
    _associatedObjects = associatedObjects;
    _created = created;
    _expires = expires;
    _livemode = livemode;
    _secret = secret;
}

  EphemeralKey.fromJson(dynamic json) {
    _id = json['id'];
    _object = json['object'];
    if (json['associated_objects'] != null) {
      _associatedObjects = [];
      json['associated_objects'].forEach((v) {
        _associatedObjects?.add(AssociatedObjects.fromJson(v));
      });
    }
    _created = json['created'];
    _expires = json['expires'];
    _livemode = json['livemode'];
    _secret = json['secret'];
  }
  String? _id;
  String? _object;
  List<AssociatedObjects>? _associatedObjects;
  int? _created;
  int? _expires;
  bool? _livemode;
  String? _secret;
EphemeralKey copyWith({  String? id,
  String? object,
  List<AssociatedObjects>? associatedObjects,
  int? created,
  int? expires,
  bool? livemode,
  String? secret,
}) => EphemeralKey(  id: id ?? _id,
  object: object ?? _object,
  associatedObjects: associatedObjects ?? _associatedObjects,
  created: created ?? _created,
  expires: expires ?? _expires,
  livemode: livemode ?? _livemode,
  secret: secret ?? _secret,
);
  String? get id => _id;
  String? get object => _object;
  List<AssociatedObjects>? get associatedObjects => _associatedObjects;
  int? get created => _created;
  int? get expires => _expires;
  bool? get livemode => _livemode;
  String? get secret => _secret;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['object'] = _object;
    if (_associatedObjects != null) {
      map['associated_objects'] = _associatedObjects?.map((v) => v.toJson()).toList();
    }
    map['created'] = _created;
    map['expires'] = _expires;
    map['livemode'] = _livemode;
    map['secret'] = _secret;
    return map;
  }

}