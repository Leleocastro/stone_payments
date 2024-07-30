import 'dart:convert';

class TransactionTypeInfo {
  final String? appLabel;
  final int? id;
  final String? transTypeEnum;

  TransactionTypeInfo({
    this.appLabel,
    this.id,
    this.transTypeEnum,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'appLabel': appLabel,
      'id': id,
      'transTypeEnum': transTypeEnum,
    };
  }

  factory TransactionTypeInfo.fromMap(Map<String, dynamic> map) {
    return TransactionTypeInfo(
      appLabel: map['appLabel'] != null ? map['appLabel'] as String : null,
      id: map['id'] != null ? map['id'] as int : null,
      transTypeEnum: map['transTypeEnum'] != null ? map['transTypeEnum'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionTypeInfo.fromJson(String source) => TransactionTypeInfo.fromMap(json.decode(source) as Map<String, dynamic>);
}
