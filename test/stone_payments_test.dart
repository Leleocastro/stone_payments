import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:stone_payments/enums/type_owner_print_enum.dart';
import 'package:stone_payments/enums/type_transaction_enum.dart';
import 'package:stone_payments/stone_payments.dart';
import 'package:stone_payments/stone_payments_method_channel.dart';
import 'package:stone_payments/stone_payments_platform_interface.dart';

class MockStonePaymentsPlatform
    with MockPlatformInterfaceMixin
    implements StonePaymentsPlatform {
  @override
  Future<String?> activateStone(
      {required String appName, required String stoneCode}) {
    return Future.value('Activated');
  }

  @override
  Stream<String> get onMessage => Stream.value('Message');

  @override
  Future<String?> printFile(String imgBase64) {
    return Future.value('Printed Image');
  }

  @override
  Future<String?> payment({
    required double value,
    required TypeTransactionEnum typeTransaction,
    int installment = 1,
    bool? printReceipt,
  }) {
    return Future.value('Paied');
  }

  @override
  Future<String?> printReceipt(TypeOwnerPrintEnum type) {
    return Future.value('Printed Receipt');
  }
  
  @override
  Future printLineToLine(List lines) {
    return Future.value('print');
  }
}

void main() {
  late StonePaymentsPlatform initialPlatform;
  late StonePayments stonePaymentsPlugin;
  late MockStonePaymentsPlatform fakePlatform;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    initialPlatform = StonePaymentsPlatform.instance;
    stonePaymentsPlugin = StonePayments();
    fakePlatform = MockStonePaymentsPlatform();
    StonePaymentsPlatform.instance = fakePlatform;
  });
  test('$MethodChannelStonePayments is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelStonePayments>());
  });

  group('StonePayments', () {
    test('payment should return status of payment', () async {
      double value = 100.00;
      TypeTransactionEnum typeTransaction = TypeTransactionEnum.credit;
      int installment = 1;
      bool printReceipt = false;

      String? result = await stonePaymentsPlugin.payment(
        value: value,
        typeTransaction: typeTransaction,
        installment: installment,
        printReceipt: printReceipt,
      );

      expect(result, isA<String>());
    });

    test('payment throws assertion error when value is not greater than 0',
        () async {
      expect(
        () async => await StonePayments().payment(
          value: -100.0,
          typeTransaction: TypeTransactionEnum.credit,
          installment: 1,
          printReceipt: true,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test(
        'payment throws assertion error when installment is not greater than 0',
        () async {
      expect(
        () async => await StonePayments().payment(
          value: 100.0,
          typeTransaction: TypeTransactionEnum.credit,
          installment: 0,
          printReceipt: true,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test(
        'payment throws assertion error when installment is greater than or equal to 13',
        () async {
      expect(
        () async => await StonePayments().payment(
          value: 100.0,
          typeTransaction: TypeTransactionEnum.credit,
          installment: 13,
          printReceipt: true,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('activateStone should return status of activation', () async {
      String appName = 'Test App';
      String stoneCode = '12345';

      String? result = await stonePaymentsPlugin.activateStone(
        appName: appName,
        stoneCode: stoneCode,
      );

      expect(result, isA<String>());
    });
     test('printLineToLine should return status of printing', () async {
      List<String> lines = [];

      String? result = await stonePaymentsPlugin.printLineToLine(lines);

      expect(result, isA<String>());
    });

    test('printFile should return status of printing', () async {
      String imgBase64 = 'image in base64';

      String? result = await stonePaymentsPlugin.printFile(imgBase64);

      expect(result, isA<String>());
    });

    test('printReceipt should return status of printing', () async {
      TypeOwnerPrintEnum type = TypeOwnerPrintEnum.client;

      String? result = await stonePaymentsPlugin.printReceipt(type);

      expect(result, isA<String>());
    });

    test('onMessageListener should return StreamSubscription', () {
      StreamSubscription<String> Function(
        ValueChanged<String>?, {
        bool? cancelOnError,
        VoidCallback? onDone,
        Function? onError,
      }) result = stonePaymentsPlugin.onMessageListener;

      expect(
          result,
          isA<
              StreamSubscription<String> Function(
            ValueChanged<String>?, {
            bool? cancelOnError,
            VoidCallback? onDone,
            Function? onError,
          })>());
    });
  });
}
