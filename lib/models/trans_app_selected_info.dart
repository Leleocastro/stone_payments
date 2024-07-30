import 'dart:convert';

import 'package:stone_payments/models/transaction_type_info.dart';

/// TransAppSelectedInfo
class TransAppSelectedInfo {
  /// Application ID
  final String? aid;

  /// Brand ID
  final int? brandId;

  /// Brand name
  final String? brandName;

  /// Card application label
  final String? cardAppLabel;

  /// Payment business model
  final String? paymentBusinessModel;

  /// Transaction type info
  final TransactionTypeInfo? transactionTypeInfo;

  /// Constructor
  TransAppSelectedInfo({
    this.aid,
    this.brandId,
    this.brandName,
    this.cardAppLabel,
    this.paymentBusinessModel,
    this.transactionTypeInfo,
  });

  /// Generate a map from the object
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'aid': aid,
      'brandId': brandId,
      'brandName': brandName,
      'cardAppLabel': cardAppLabel,
      'paymentBusinessModel': paymentBusinessModel,
      'transactionTypeInfo': transactionTypeInfo?.toMap(),
    };
  }

  /// Generate an object from the map
  factory TransAppSelectedInfo.fromMap(Map<String, dynamic> map) {
    return TransAppSelectedInfo(
      aid: map['aid'] != null ? map['aid'] as String : null,
      brandId: map['brandId'] != null ? map['brandId'] as int : null,
      brandName: map['brandName'] != null ? map['brandName'] as String : null,
      cardAppLabel:
          map['cardAppLabel'] != null ? map['cardAppLabel'] as String : null,
      paymentBusinessModel: map['paymentBusinessModel'] != null
          ? map['paymentBusinessModel'] as String
          : null,
      transactionTypeInfo: map['transactionTypeInfo'] != null
          ? TransactionTypeInfo.fromMap(
              map['transactionTypeInfo'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Generate a JSON from the object
  String toJson() => json.encode(toMap());

  /// Generate an object from the JSON
  factory TransAppSelectedInfo.fromJson(String source) =>
      TransAppSelectedInfo.fromMap(json.decode(source) as Map<String, dynamic>);
}
