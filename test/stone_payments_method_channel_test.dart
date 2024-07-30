import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stone_payments/enums/item_print_type_enum.dart';
import 'package:stone_payments/enums/type_owner_print_enum.dart';
import 'package:stone_payments/enums/type_transaction_enum.dart';
import 'package:stone_payments/models/item_print_model.dart';
import 'package:stone_payments/stone_payments_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelStonePayments platform = MethodChannelStonePayments();
  const MethodChannel channel = MethodChannel('stone_payments');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'payment':
          return '42';
        case 'transaction':
          return '{"actionCode": "123", "transactionStatus": "success"}';
        case 'activateStone':
          return 'activated';
        case 'print':
          return 'printed';
        case 'printReceipt':
          return 'receipt_printed';
        default:
          return null;
      }
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, (null));
  });

  test('payment', () async {
    expect(
      await platform.payment(
        value: 10,
        typeTransaction: TypeTransactionEnum.debit,
      ),
      '42',
    );
  });

  test('transaction', () async {
    final transaction = await platform.transaction(
      value: 10,
      typeTransaction: TypeTransactionEnum.debit,
    );
    expect(transaction, isNotNull);
    expect(transaction!.actionCode, '123');
    expect(transaction.transactionStatus, 'success');
  });

  test('activateStone', () async {
    expect(
      await platform.activateStone(
        appName: 'TestApp',
        stoneCode: '123456',
      ),
      'activated',
    );
  });

  test('print', () async {
    final items = [
      const ItemPrintModel(
        data: '1',
        type: ItemPrintTypeEnum.text,
      )
    ];
    expect(
      await platform.print(items),
      'printed',
    );
  });

  test('printReceipt', () async {
    expect(
      await platform.printReceipt(TypeOwnerPrintEnum.merchant),
      'receipt_printed',
    );
  });
}
