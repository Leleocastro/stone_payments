import 'dart:convert';

import 'package:stone_payments/models/trans_app_selected_info.dart';

/// Transaction
class Transaction {
  /// Acquirer transaction key
  final String? acquirerTransactionKey;

  /// Action code
  final String? actionCode;

  /// AID
  final String? aid;

  /// Amount
  final String? amount;

  /// Application label
  final String? appLabel;

  /// ARCQ
  final String? arcq;

  /// Authorization code
  final String? authorizationCode;

  /// Capture
  final bool? capture;

  /// Card brand
  final String? cardBrand;

  /// Card brand ID
  final int? cardBrandId;

  /// Card brand name
  final String? cardBrandName;

  /// Card expire date
  final String? cardExpireDate;

  /// Card holder name
  final String? cardHolderName;

  /// Card holder number
  final String? cardHolderNumber;

  /// Card sequence number
  final String? cardSequenceNumber;

  /// Command action code
  final String? commandActionCode;

  /// Date
  final String? date;

  /// Entry mode
  final String? entryMode;

  /// ICC related data
  final String? iccRelatedData;

  /// ID from base
  final int? idFromBase;

  /// Initiator transaction key
  final String? initiatorTransactionKey;

  /// Instalment transaction
  final String? instalmentTransaction;

  /// Instalment type
  final String? instalmentType;

  /// Is fallback transaction
  final bool? isFallbackTransaction;

  /// Qualifiers
  final List<String>? qualifiers;

  /// Sale affiliation key
  final String? saleAffiliationKey;

  /// Service code
  final String? serviceCode;

  /// Time
  final String? time;

  /// Time to pass transaction
  final String? timeToPassTransaction;

  /// Transaction app selected info
  final TransAppSelectedInfo? transAppSelectedInfo;

  /// Transaction reference
  final String? transactionReference;

  /// Transaction status
  final String? transactionStatus;

  /// Type of transaction enum
  final String? typeOfTransactionEnum;

  /// Constructor
  Transaction({
    this.acquirerTransactionKey,
    this.actionCode,
    this.aid,
    this.amount,
    this.appLabel,
    this.arcq,
    this.authorizationCode,
    this.capture,
    this.cardBrand,
    this.cardBrandId,
    this.cardBrandName,
    this.cardExpireDate,
    this.cardHolderName,
    this.cardHolderNumber,
    this.cardSequenceNumber,
    this.commandActionCode,
    this.date,
    this.entryMode,
    this.iccRelatedData,
    this.idFromBase,
    this.initiatorTransactionKey,
    this.instalmentTransaction,
    this.instalmentType,
    this.isFallbackTransaction,
    this.qualifiers,
    this.saleAffiliationKey,
    this.serviceCode,
    this.time,
    this.timeToPassTransaction,
    this.transAppSelectedInfo,
    this.transactionReference,
    this.transactionStatus,
    this.typeOfTransactionEnum,
  });

  /// Generate a map from the object
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'acquirerTransactionKey': acquirerTransactionKey,
      'actionCode': actionCode,
      'aid': aid,
      'amount': amount,
      'appLabel': appLabel,
      'arcq': arcq,
      'authorizationCode': authorizationCode,
      'capture': capture,
      'cardBrand': cardBrand,
      'cardBrandId': cardBrandId,
      'cardBrandName': cardBrandName,
      'cardExpireDate': cardExpireDate,
      'cardHolderName': cardHolderName,
      'cardHolderNumber': cardHolderNumber,
      'cardSequenceNumber': cardSequenceNumber,
      'commandActionCode': commandActionCode,
      'date': date,
      'entryMode': entryMode,
      'iccRelatedData': iccRelatedData,
      'idFromBase': idFromBase,
      'initiatorTransactionKey': initiatorTransactionKey,
      'instalmentTransaction': instalmentTransaction,
      'instalmentType': instalmentType,
      'isFallbackTransaction': isFallbackTransaction,
      'qualifiers': qualifiers,
      'saleAffiliationKey': saleAffiliationKey,
      'serviceCode': serviceCode,
      'time': time,
      'timeToPassTransaction': timeToPassTransaction,
      'transAppSelectedInfo': transAppSelectedInfo?.toMap(),
      'transactionReference': transactionReference,
      'transactionStatus': transactionStatus,
      'typeOfTransactionEnum': typeOfTransactionEnum,
    };
  }

  /// Generate an object from the map
  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      acquirerTransactionKey: map['acquirerTransactionKey'] != null
          ? map['acquirerTransactionKey'] as String
          : null,
      actionCode:
          map['actionCode'] != null ? map['actionCode'] as String : null,
      aid: map['aid'] != null ? map['aid'] as String : null,
      amount: map['amount'] != null ? map['amount'] as String : null,
      appLabel: map['appLabel'] != null ? map['appLabel'] as String : null,
      arcq: map['arcq'] != null ? map['arcq'] as String : null,
      authorizationCode: map['authorizationCode'] != null
          ? map['authorizationCode'] as String
          : null,
      capture: map['capture'] != null ? map['capture'] as bool : null,
      cardBrand: map['cardBrand'] != null ? map['cardBrand'] as String : null,
      cardBrandId:
          map['cardBrandId'] != null ? map['cardBrandId'] as int : null,
      cardBrandName:
          map['cardBrandName'] != null ? map['cardBrandName'] as String : null,
      cardExpireDate: map['cardExpireDate'] != null
          ? map['cardExpireDate'] as String
          : null,
      cardHolderName: map['cardHolderName'] != null
          ? map['cardHolderName'] as String
          : null,
      cardHolderNumber: map['cardHolderNumber'] != null
          ? map['cardHolderNumber'] as String
          : null,
      cardSequenceNumber: map['cardSequenceNumber'] != null
          ? map['cardSequenceNumber'] as String
          : null,
      commandActionCode: map['commandActionCode'] != null
          ? map['commandActionCode'] as String
          : null,
      date: map['date'] != null ? map['date'] as String : null,
      entryMode: map['entryMode'] != null ? map['entryMode'] as String : null,
      iccRelatedData: map['iccRelatedData'] != null
          ? map['iccRelatedData'] as String
          : null,
      idFromBase: map['idFromBase'] != null ? map['idFromBase'] as int : null,
      initiatorTransactionKey: map['initiatorTransactionKey'] != null
          ? map['initiatorTransactionKey'] as String
          : null,
      instalmentTransaction: map['instalmentTransaction'] != null
          ? map['instalmentTransaction'] as String
          : null,
      instalmentType: map['instalmentType'] != null
          ? map['instalmentType'] as String
          : null,
      isFallbackTransaction: map['isFallbackTransaction'] != null
          ? map['isFallbackTransaction'] as bool
          : null,
      qualifiers: map['qualifiers'] != null
          ? List<String>.from((map['qualifiers'] as List))
          : null,
      saleAffiliationKey: map['saleAffiliationKey'] != null
          ? map['saleAffiliationKey'] as String
          : null,
      serviceCode:
          map['serviceCode'] != null ? map['serviceCode'] as String : null,
      time: map['time'] != null ? map['time'] as String : null,
      timeToPassTransaction: map['timeToPassTransaction'] != null
          ? map['timeToPassTransaction'] as String
          : null,
      transAppSelectedInfo: map['transAppSelectedInfo'] != null
          ? TransAppSelectedInfo.fromMap(
              map['transAppSelectedInfo'] as Map<String, dynamic>)
          : null,
      transactionReference: map['transactionReference'] != null
          ? map['transactionReference'] as String
          : null,
      transactionStatus: map['transactionStatus'] != null
          ? map['transactionStatus'] as String
          : null,
      typeOfTransactionEnum: map['typeOfTransactionEnum'] != null
          ? map['typeOfTransactionEnum'] as String
          : null,
    );
  }

  /// Generate a JSON from the object
  String toJson() => json.encode(toMap());

  /// Generate an object from the JSON
  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source) as Map<String, dynamic>);
}
