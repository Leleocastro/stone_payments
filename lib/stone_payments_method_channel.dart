import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:stone_payments/enums/status_transaction_enum.dart';

import 'enums/type_transaction_enum.dart';
import 'stone_payments_platform_interface.dart';

/// An implementation of [StonePaymentsPlatform] that uses method channels.
class MethodChannelStonePayments extends StonePaymentsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('stone_payments');

  final _paymentController = StreamController<String>.broadcast();

  @override
  Stream<String> get onMessage => _paymentController.stream;

  MethodChannelStonePayments() {
    methodChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'message':
          _paymentController
              .add(StatusTransactionEnum.fromName(call.arguments));
          break;
        default:
          _paymentController.add(call.arguments);
          break;
      }
    });
  }

  @override
  Future<String?> payment({
    required double value,
    required TypeTransactionEnum typeTransaction,
    int installment = 1,
    bool? printReceipt,
  }) async {
    final result = await methodChannel.invokeMethod<String>(
      'payment',
      <String, dynamic>{
        'value': value,
        'typeTransaction': typeTransaction.value,
        'installment': installment,
        'printReceipt': printReceipt,
      },
    );

    return result;
  }

  @override
  Future<String?> activateStone({
    required String appName,
    required String stoneCode,
  }) async {
    final result = await methodChannel.invokeMethod<String>(
      'activateStone',
      <String, dynamic>{
        'appName': appName,
        'stoneCode': stoneCode,
      },
    );

    return result;
  }

  @override
  Future<String?> printFile(String imgBase64) async {
    final result = await methodChannel.invokeMethod<String>(
      'printFile',
      <String, dynamic>{
        'imgBase64': imgBase64,
      },
    );

    return result;
  }
}
