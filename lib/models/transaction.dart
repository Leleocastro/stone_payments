import 'dart:convert';

import 'package:stone_payments/models/trans_app_selected_info.dart';

class Transaction {
  final String? acquirerTransactionKey;
  final String? actionCode;
  final String? aid;
  final String? amount;
  final String? appLabel;
  final String? arcq;
  final String? authorizationCode;
  final bool? capture;
  final String? cardBrand;
  final int? cardBrandId;
  final String? cardBrandName;
  final String? cardExpireDate;
  final String? cardHolderName;
  final String? cardHolderNumber;
  final String? cardSequenceNumber;
  final String? commandActionCode;
  final String? date;
  final String? entryMode;
  final String? iccRelatedData;
  final int? idFromBase;
  final String? initiatorTransactionKey;
  final String? instalmentTransaction;
  final String? instalmentType;
  final bool? isFallbackTransaction;
  final List<String>? qualifiers;
  final String? saleAffiliationKey;
  final String? serviceCode;
  final String? time;
  final String? timeToPassTransaction;
  final TransAppSelectedInfo? transAppSelectedInfo;
  final String? transactionReference;
  final String? transactionStatus;
  final String? typeOfTransactionEnum;

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

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      acquirerTransactionKey: map['acquirerTransactionKey'] != null ? map['acquirerTransactionKey'] as String : null,
      actionCode: map['actionCode'] != null ? map['actionCode'] as String : null,
      aid: map['aid'] != null ? map['aid'] as String : null,
      amount: map['amount'] != null ? map['amount'] as String : null,
      appLabel: map['appLabel'] != null ? map['appLabel'] as String : null,
      arcq: map['arcq'] != null ? map['arcq'] as String : null,
      authorizationCode: map['authorizationCode'] != null ? map['authorizationCode'] as String : null,
      capture: map['capture'] != null ? map['capture'] as bool : null,
      cardBrand: map['cardBrand'] != null ? map['cardBrand'] as String : null,
      cardBrandId: map['cardBrandId'] != null ? map['cardBrandId'] as int : null,
      cardBrandName: map['cardBrandName'] != null ? map['cardBrandName'] as String : null,
      cardExpireDate: map['cardExpireDate'] != null ? map['cardExpireDate'] as String : null,
      cardHolderName: map['cardHolderName'] != null ? map['cardHolderName'] as String : null,
      cardHolderNumber: map['cardHolderNumber'] != null ? map['cardHolderNumber'] as String : null,
      cardSequenceNumber: map['cardSequenceNumber'] != null ? map['cardSequenceNumber'] as String : null,
      commandActionCode: map['commandActionCode'] != null ? map['commandActionCode'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      entryMode: map['entryMode'] != null ? map['entryMode'] as String : null,
      iccRelatedData: map['iccRelatedData'] != null ? map['iccRelatedData'] as String : null,
      idFromBase: map['idFromBase'] != null ? map['idFromBase'] as int : null,
      initiatorTransactionKey: map['initiatorTransactionKey'] != null ? map['initiatorTransactionKey'] as String : null,
      instalmentTransaction: map['instalmentTransaction'] != null ? map['instalmentTransaction'] as String : null,
      instalmentType: map['instalmentType'] != null ? map['instalmentType'] as String : null,
      isFallbackTransaction: map['isFallbackTransaction'] != null ? map['isFallbackTransaction'] as bool : null,
      qualifiers: map['qualifiers'] != null ? List<String>.from((map['qualifiers'] as List)) : null,
      saleAffiliationKey: map['saleAffiliationKey'] != null ? map['saleAffiliationKey'] as String : null,
      serviceCode: map['serviceCode'] != null ? map['serviceCode'] as String : null,
      time: map['time'] != null ? map['time'] as String : null,
      timeToPassTransaction: map['timeToPassTransaction'] != null ? map['timeToPassTransaction'] as String : null,
      transAppSelectedInfo: map['transAppSelectedInfo'] != null ? TransAppSelectedInfo.fromMap(map['transAppSelectedInfo'] as Map<String, dynamic>) : null,
      transactionReference: map['transactionReference'] != null ? map['transactionReference'] as String : null,
      transactionStatus: map['transactionStatus'] != null ? map['transactionStatus'] as String : null,
      typeOfTransactionEnum: map['typeOfTransactionEnum'] != null ? map['typeOfTransactionEnum'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) => Transaction.fromMap(json.decode(source) as Map<String, dynamic>);
}
