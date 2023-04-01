import 'dart:async';

import 'package:flutter/widgets.dart';

import 'enums/type_transaction_enum.dart';
import 'stone_payments_platform_interface.dart';

class StonePayments {
  Future<String?> payment({
    required double value,
    required TypeTransactionEnum typeTransaction,
    int installment = 1,
    bool? printReceipt,
  }) {
    return StonePaymentsPlatform.instance.payment(
      value: value,
      typeTransaction: typeTransaction,
      installment: installment,
      printReceipt: printReceipt,
    );
  }

  Future<String?> activateStone({
    required String appName,
    required String stoneCode,
  }) {
    return StonePaymentsPlatform.instance.activateStone(
      appName: appName,
      stoneCode: stoneCode,
    );
  }

  Future<String?> printFile(String imgBase64) {
    return StonePaymentsPlatform.instance.printFile(imgBase64);
  }

  StreamSubscription<String> Function(
    ValueChanged<String>?, {
    bool? cancelOnError,
    VoidCallback? onDone,
    Function? onError,
  }) get onMessageListener => StonePaymentsPlatform.instance.onMessage.listen;
}
