import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:stone_payments/enums/item_print_type_enum.dart';
import 'package:stone_payments/enums/type_owner_print_enum.dart';
import 'package:stone_payments/enums/type_transaction_enum.dart';
import 'package:stone_payments/models/item_print_model.dart';
import 'package:stone_payments/models/transaction.dart';
import 'package:stone_payments/stone_payments.dart';
import 'package:stone_payments/stone_payments_method_channel.dart';
import 'package:stone_payments/stone_payments_platform_interface.dart';

class MockStonePaymentsPlatform with MockPlatformInterfaceMixin implements StonePaymentsPlatform {
  @override
  Future<String?> activateStone({
    required String appName,
    required String stoneCode,
    String? qrCodeProviderId,
    String? qrCodeAuthorization,
  }) {
    return Future.value('Activated');
  }

  @override
  Stream<String> get onMessage => Stream.value('Message');

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
  Future<Transaction?> transaction({
    required double value,
    required TypeTransactionEnum typeTransaction,
    int installment = 1,
    bool? printReceipt,
    ValueChanged<String>? onPixQrCode,
  }) {
    return Future.value(Transaction());
  }

  @override
  Future<String?> printReceipt(TypeOwnerPrintEnum type) {
    return Future.value('Printed Receipt');
  }

  @override
  Future<String?> print(List<ItemPrintModel> items) {
    return Future.value('Printed Items');
  }
}

void main() {
  late StonePaymentsPlatform initialPlatform;
  late MockStonePaymentsPlatform fakePlatform;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    initialPlatform = StonePaymentsPlatform.instance;
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

      String? result = await StonePayments.payment(
        value: value,
        typeTransaction: typeTransaction,
        installment: installment,
        printReceipt: printReceipt,
      );

      expect(result, isA<String>());
    });

    test('payment throws assertion error when value is not greater than 0', () async {
      expect(
        () async => await StonePayments.payment(
          value: -100.0,
          typeTransaction: TypeTransactionEnum.credit,
          installment: 1,
          printReceipt: true,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('payment throws assertion error when installment is not greater than 0', () async {
      expect(
        () async => await StonePayments.payment(
          value: 100.0,
          typeTransaction: TypeTransactionEnum.credit,
          installment: 0,
          printReceipt: true,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('payment throws assertion error when installment is greater than or equal to 13', () async {
      expect(
        () async => await StonePayments.payment(
          value: 100.0,
          typeTransaction: TypeTransactionEnum.credit,
          installment: 13,
          printReceipt: true,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('transaction should return the transaction object', () async {
      double value = 100.00;
      TypeTransactionEnum typeTransaction = TypeTransactionEnum.credit;
      int installment = 1;
      bool printReceipt = false;

      var result = await StonePayments.transaction(
        value: value,
        typeTransaction: typeTransaction,
        installment: installment,
        printReceipt: printReceipt,
      );

      expect(result, isA<Transaction>());
    });

    test('transaction throws assertion error when value is not greater than 0', () async {
      expect(
        () async => await StonePayments.transaction(
          value: -100.0,
          typeTransaction: TypeTransactionEnum.credit,
          installment: 1,
          printReceipt: true,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('transaction throws assertion error when installment is not greater than 0', () async {
      expect(
        () async => await StonePayments.transaction(
          value: 100.0,
          typeTransaction: TypeTransactionEnum.credit,
          installment: 0,
          printReceipt: true,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('transaction throws assertion error when installment is greater than or equal to 13', () async {
      expect(
        () async => await StonePayments.transaction(
          value: 100.0,
          typeTransaction: TypeTransactionEnum.credit,
          installment: 13,
          printReceipt: true,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('transaction should throw assertion error for debit transaction with installment greater than 1', () {
      expect(
        () => StonePayments.transaction(
          value: 100.00,
          typeTransaction: TypeTransactionEnum.debit,
          installment: 2,
        ),
        throwsA(isA<AssertionError>().having(
          (e) => e.message,
          'message',
          'Pagamentos débito não pode ser parcelados.',
        )),
      );
    });

    test('activateStone should return status of activation', () async {
      String appName = 'Test App';
      String stoneCode = '12345';

      String? result = await StonePayments.activateStone(
        appName: appName,
        stoneCode: stoneCode,
      );

      expect(result, isA<String>());
    });

    test('print should return status of printing', () async {
      List<ItemPrintModel> items = [
        const ItemPrintModel(
          type: ItemPrintTypeEnum.text,
          data: 'Test',
        ),
        const ItemPrintModel(
          type: ItemPrintTypeEnum.image,
          data: 'ImageTest',
        ),
      ];

      String? result = await StonePayments.print(items);

      expect(result, isA<String>());
    });

    test('printReceipt should return status of printing', () async {
      TypeOwnerPrintEnum type = TypeOwnerPrintEnum.client;

      String? result = await StonePayments.printReceipt(type);

      expect(result, isA<String>());
    });

    test('onMessageListener should return StreamSubscription', () {
      StreamSubscription<String> Function(
        ValueChanged<String>?, {
        bool? cancelOnError,
        VoidCallback? onDone,
        Function? onError,
      }) result = StonePayments.onMessageListener;

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
