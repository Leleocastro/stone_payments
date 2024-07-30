import 'dart:convert';

import 'package:stone_payments/models/transaction_type_info.dart';

class TransAppSelectedInfo {
  final String? aid;
  final int? brandId;
  final String? brandName;
  final String? cardAppLabel;
  final String? paymentBusinessModel;
  final TransactionTypeInfo? transactionTypeInfo;

  TransAppSelectedInfo({
    this.aid,
    this.brandId,
    this.brandName,
    this.cardAppLabel,
    this.paymentBusinessModel,
    this.transactionTypeInfo,
  });

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

  factory TransAppSelectedInfo.fromMap(Map<String, dynamic> map) {
    return TransAppSelectedInfo(
      aid: map['aid'] != null ? map['aid'] as String : null,
      brandId: map['brandId'] != null ? map['brandId'] as int : null,
      brandName: map['brandName'] != null ? map['brandName'] as String : null,
      cardAppLabel: map['cardAppLabel'] != null ? map['cardAppLabel'] as String : null,
      paymentBusinessModel: map['paymentBusinessModel'] != null ? map['paymentBusinessModel'] as String : null,
      transactionTypeInfo: map['transactionTypeInfo'] != null ? TransactionTypeInfo.fromMap(map['transactionTypeInfo'] as Map<String, dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransAppSelectedInfo.fromJson(String source) => TransAppSelectedInfo.fromMap(json.decode(source) as Map<String, dynamic>);
}
