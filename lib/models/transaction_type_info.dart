import 'dart:convert';

/// TransactionTypeInfo
class TransactionTypeInfo {
  /// Application label
  final String? appLabel;

  /// ID
  final int? id;

  /// Transaction type enum
  final String? transTypeEnum;

  /// Constructor
  TransactionTypeInfo({
    this.appLabel,
    this.id,
    this.transTypeEnum,
  });

  /// Generate a map from the object
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'appLabel': appLabel,
      'id': id,
      'transTypeEnum': transTypeEnum,
    };
  }

  /// Generate an object from the map
  factory TransactionTypeInfo.fromMap(Map<String, dynamic> map) {
    return TransactionTypeInfo(
      appLabel: map['appLabel'] != null ? map['appLabel'] as String : null,
      id: map['id'] != null ? map['id'] as int : null,
      transTypeEnum:
          map['transTypeEnum'] != null ? map['transTypeEnum'] as String : null,
    );
  }

  /// Generate a JSON from the object
  String toJson() => json.encode(toMap());

  /// Generate an object from the JSON
  factory TransactionTypeInfo.fromJson(String source) =>
      TransactionTypeInfo.fromMap(json.decode(source) as Map<String, dynamic>);
}
