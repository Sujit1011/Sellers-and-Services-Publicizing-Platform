import 'dart:convert';

import 'package:flutter/foundation.dart';

class SS_Shop {
  final String id;
  final String businessId;
  String name;
  String address;
  String? category;
  String? workingHours;
  String description;
  List<String>? licensesAndCertificates;
  List<String>? products;
  String phoneNo;
  String? email;
  String? photo;
  String joinDate;
  String? reviews;
  String? ratings;


  SS_Shop({
    required this.id,
    required this.businessId,
    required this.name,
    required this.address,
    this.category,
    this.workingHours,
    required this.description,
    this.licensesAndCertificates,
    this.products,
    required this.phoneNo,
    this.email,
    this.photo,
    required this.joinDate,
    this.reviews,
    this.ratings,
  });

  SS_Shop copyWith({
    String? id,
    String? businessId,
    String? name,
    String? address,
    String? category,
    String? workingHours,
    String? description,
    List<String>? licensesAndCertificates,
    List<String>? products,
    String? phoneNo,
    String? email,
    String? photo,
    String? joinDate,
    String? reviews,
    String? ratings,
  }) {
    return SS_Shop(
      id: id ?? this.id,
      businessId: businessId ?? this.businessId,
      name: name ?? this.name,
      address: address ?? this.address,
      category: category ?? this.category,
      workingHours: workingHours ?? this.workingHours,
      description: description ?? this.description,
      licensesAndCertificates: licensesAndCertificates ?? this.licensesAndCertificates,
      products: products ?? this.products,
      phoneNo: phoneNo ?? this.phoneNo,
      email: email ?? this.email,
      photo: photo ?? this.photo,
      joinDate: joinDate ?? this.joinDate,
      reviews: reviews ?? this.reviews,
      ratings: ratings ?? this.ratings,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'businessId': businessId});
    if(name != null){
      result.addAll({'name': name});
    }
    if(address != null){
      result.addAll({'address': address});
    }
    if(category != null){
      result.addAll({'category': category});
    }
    if(workingHours != null){
      result.addAll({'workingHours': workingHours});
    }
    if(description != null){
      result.addAll({'description': description});
    }
    if(licensesAndCertificates != null){
      result.addAll({'licensesAndCertificates': licensesAndCertificates});
    }
    if(products != null){
      result.addAll({'products': products});
    }
    if(phoneNo != null){
      result.addAll({'phoneNo': phoneNo});
    }
    if(email != null){
      result.addAll({'email': email});
    }
    if(photo != null){
      result.addAll({'photo': photo});
    }
    if(joinDate != null){
      result.addAll({'joinDate': joinDate});
    }
    if(reviews != null){
      result.addAll({'reviews': reviews});
    }
    if(ratings != null){
      result.addAll({'ratings': ratings});
    }
  
    return result;
  }

  factory SS_Shop.fromMap(Map<String, dynamic> map) {
    return SS_Shop(
      id: map['id'] ?? '',
      businessId: map['businessId'] ?? '',
      name: map['name'],
      address: map['address'],
      category: map['category'],
      workingHours: map['workingHours'],
      description: map['description'],
      licensesAndCertificates: List<String>.from(map['licensesAndCertificates']),
      products: List<String>.from(map['products']),
      phoneNo: map['phoneNo'],
      email: map['email'],
      photo: map['photo'],
      joinDate: map['joinDate'],
      reviews: map['reviews'],
      ratings: map['ratings'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SS_Shop.fromJson(String source) => SS_Shop.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SS_Shop(id: $id, businessId: $businessId, name: $name, address: $address, category: $category, workingHours: $workingHours, description: $description, licensesAndCertificates: $licensesAndCertificates, products: $products, phoneNo: $phoneNo, email: $email, photo: $photo, joinDate: $joinDate, reviews: $reviews, ratings: $ratings)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SS_Shop &&
      other.id == id &&
      other.businessId == businessId &&
      other.name == name &&
      other.address == address &&
      other.category == category &&
      other.workingHours == workingHours &&
      other.description == description &&
      listEquals(other.licensesAndCertificates, licensesAndCertificates) &&
      listEquals(other.products, products) &&
      other.phoneNo == phoneNo &&
      other.email == email &&
      other.photo == photo &&
      other.joinDate == joinDate &&
      other.reviews == reviews &&
      other.ratings == ratings;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      businessId.hashCode ^
      name.hashCode ^
      address.hashCode ^
      category.hashCode ^
      workingHours.hashCode ^
      description.hashCode ^
      licensesAndCertificates.hashCode ^
      products.hashCode ^
      phoneNo.hashCode ^
      email.hashCode ^
      photo.hashCode ^
      joinDate.hashCode ^
      reviews.hashCode ^
      ratings.hashCode;
  }
}
