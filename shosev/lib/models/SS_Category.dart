import 'dart:convert' show json;

import 'package:flutter/foundation.dart' show listEquals;

class SS_Category {
  final String id;
  String? category;
  List<String>? shops;
  List<String>? services;

  SS_Category({
    required this.id,
    this.category,
    this.shops,
    this.services,
  });
  

  SS_Category copyWith({
    String? id,
    String? category,
    List<String>? shops,
    List<String>? services,
  }) {
    return SS_Category(
      id: id ?? this.id,
      category: category ?? this.category,
      shops: shops ?? this.shops,
      services: services ?? this.services,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    if(category != null){
      result.addAll({'category': category});
    }
    if(shops != null){
      result.addAll({'shops': shops});
    }
    if(services != null){
      result.addAll({'services': services});
    }
  
    return result;
  }

  factory SS_Category.fromMap(Map<String, dynamic> map) {
    return SS_Category(
      id: map['id'] ?? '',
      category: map['category'],
      shops: List<String>.from(map['shops']),
      services: List<String>.from(map['services']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SS_Category.fromJson(String source) => SS_Category.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SS_Category(id: $id, category: $category, shops: $shops, services: $services)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SS_Category &&
      other.id == id &&
      other.category == category &&
      listEquals(other.shops, shops) &&
      listEquals(other.services, services);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      category.hashCode ^
      shops.hashCode ^
      services.hashCode;
  }
}
