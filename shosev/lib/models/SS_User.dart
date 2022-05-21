import 'dart:convert' show json;

import 'package:flutter/foundation.dart' show listEquals, mapEquals;

import 'package:shosev/models/SS_Service.dart' show SS_Service;
import 'package:shosev/models/SS_Shop.dart' show SS_Shop;

class SS_User {
  final String uid;
  final String userName;
  final String phoneNo; // 10 digits
  String? email;
  List<String>? searchHistory;
  List<String>? favouriteShops;
  List<String>? favouriteServices;
  Map<String, List<String>>? shopReviews;
  Map<String, List<String>>? serviceReviews;

  bool? businessUser;
  String? businessName;
  List<String>? licensesAndCertificates;
  List<SS_Shop>? myShops;
  List<SS_Service>? myServices;
  
  SS_User({
    required this.uid,
    required this.userName,
    required this.phoneNo,
    this.email,
    this.searchHistory,
    this.favouriteShops,
    this.favouriteServices,
    this.shopReviews,
    this.serviceReviews,
    this.businessUser,
    this.businessName,
    this.licensesAndCertificates,
    this.myShops,
    this.myServices,
  });


  SS_User copyWith({
    String? uid,
    String? userName,
    String? phoneNo,
    String? email,
    List<String>? searchHistory,
    List<String>? favouriteShops,
    List<String>? favouriteServices,
    Map<String, List<String>>? shopReviews,
    Map<String, List<String>>? serviceReviews,
    bool? businessUser,
    String? businessName,
    List<String>? licensesAndCertificates,
    List<SS_Shop>? myShops,
    List<SS_Service>? myServices,
  }) {
    return SS_User(
      uid: uid ?? this.uid,
      userName: userName ?? this.userName,
      phoneNo: phoneNo ?? this.phoneNo,
      email: email ?? this.email,
      searchHistory: searchHistory ?? this.searchHistory,
      favouriteShops: favouriteShops ?? this.favouriteShops,
      favouriteServices: favouriteServices ?? this.favouriteServices,
      shopReviews: shopReviews ?? this.shopReviews,
      serviceReviews: serviceReviews ?? this.serviceReviews,
      businessUser: businessUser ?? this.businessUser,
      businessName: businessName ?? this.businessName,
      licensesAndCertificates: licensesAndCertificates ?? this.licensesAndCertificates,
      myShops: myShops ?? this.myShops,
      myServices: myServices ?? this.myServices,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'uid': uid});
    result.addAll({'userName': userName});
    result.addAll({'phoneNo': phoneNo});
    if(email != null){
      result.addAll({'email': email});
    }
    if(searchHistory != null){
      result.addAll({'searchHistory': searchHistory});
    }
    if(favouriteShops != null){
      result.addAll({'favouriteShops': favouriteShops});
    }
    if(favouriteServices != null){
      result.addAll({'favouriteServices': favouriteServices});
    }
    if(shopReviews != null){
      result.addAll({'shopReviews': shopReviews});
    }
    if(serviceReviews != null){
      result.addAll({'serviceReviews': serviceReviews});
    }
    if(businessUser != null){
      result.addAll({'businessUser': businessUser});
    }
    if(businessName != null){
      result.addAll({'businessName': businessName});
    }
    if(licensesAndCertificates != null){
      result.addAll({'licensesAndCertificates': licensesAndCertificates});
    }
    if(myShops != null){
      result.addAll({'myShops': myShops!.map((x) => x.toMap()).toList()});
    }
    if(myServices != null){
      result.addAll({'myServices': myServices!.map((x) => x.toMap()).toList()});
    }
  
    return result;
  }

  factory SS_User.fromMap(Map<String, dynamic> map) {
    return SS_User(
      uid: map['uid'] ?? '',
      userName: map['userName'] ?? '',
      phoneNo: map['phoneNo'] ?? '',
      email: map['email'],
      searchHistory: List<String>.from(map['searchHistory']),
      favouriteShops: List<String>.from(map['favouriteShops']),
      favouriteServices: List<String>.from(map['favouriteServices']),
      shopReviews: Map<String, List<String>>.from(map['shopReviews']),
      serviceReviews: Map<String, List<String>>.from(map['serviceReviews']),
      businessUser: map['businessUser'],
      businessName: map['businessName'],
      licensesAndCertificates: List<String>.from(map['licensesAndCertificates']),
      myShops: map['myShops'] != null ? List<SS_Shop>.from(map['myShops']?.map((x) => SS_Shop.fromMap(x))) : null,
      myServices: map['myServices'] != null ? List<SS_Service>.from(map['myServices']?.map((x) => SS_Service.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SS_User.fromJson(String source) => SS_User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SS_User(uid: $uid, userName: $userName, phoneNo: $phoneNo, email: $email, searchHistory: $searchHistory, favouriteShops: $favouriteShops, favouriteServices: $favouriteServices, shopReviews: $shopReviews, serviceReviews: $serviceReviews, businessUser: $businessUser, businessName: $businessName, licensesAndCertificates: $licensesAndCertificates, myShops: $myShops, myServices: $myServices)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SS_User &&
      other.uid == uid &&
      other.userName == userName &&
      other.phoneNo == phoneNo &&
      other.email == email &&
      listEquals(other.searchHistory, searchHistory) &&
      listEquals(other.favouriteShops, favouriteShops) &&
      listEquals(other.favouriteServices, favouriteServices) &&
      mapEquals(other.shopReviews, shopReviews) &&
      mapEquals(other.serviceReviews, serviceReviews) &&
      other.businessUser == businessUser &&
      other.businessName == businessName &&
      listEquals(other.licensesAndCertificates, licensesAndCertificates) &&
      listEquals(other.myShops, myShops) &&
      listEquals(other.myServices, myServices);
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      userName.hashCode ^
      phoneNo.hashCode ^
      email.hashCode ^
      searchHistory.hashCode ^
      favouriteShops.hashCode ^
      favouriteServices.hashCode ^
      shopReviews.hashCode ^
      serviceReviews.hashCode ^
      businessUser.hashCode ^
      businessName.hashCode ^
      licensesAndCertificates.hashCode ^
      myShops.hashCode ^
      myServices.hashCode;
  }
}
