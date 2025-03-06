import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:stone_payments/enums/type_owner_print_enum.dart';
import 'package:stone_payments/models/transaction.dart';

import 'enums/type_transaction_enum.dart';
import 'models/item_print_model.dart';
import 'stone_payments_platform_interface.dart';

/// Classe responsável por interagir com a plataforma de pagamentos da Stone.
class StonePayments {
  /// Processa um pagamento na plataforma da Stone.
  ///
  /// Parâmetros:
  ///
  /// * `value` (required) - Valor do pagamento. Deve ser maior que zero.
  /// * `typeTransaction` (required) - Tipo de transação (crédito ou débito).
  /// * `installment` (optional) - Número de parcelas (padrão é 1). Deve ser maior que zero e menor que 13.
  /// * `printReceipt` (optional) - Opção para imprimir o comprovante (padrão é nulo).
  ///
  /// Retorna:
  ///
  /// * Uma `Future<String?>` com o status do pagamento. O valor pode ser nulo em caso de erro.
  @Deprecated('Use transaction() instead.')
  static Future<String?> payment({
    required double value,
    required TypeTransactionEnum typeTransaction,
    int installment = 1,
    bool? printReceipt,
  }) {
    assert(value > 0, 'O valor do pagamento deve ser maior que zero.');
    assert(
      installment > 0 && installment < 13,
      'O número de parcelas deve ser maior que zero e menor que 13.',
    );
    if (typeTransaction == TypeTransactionEnum.debit) {
      assert(installment == 1, 'Pagamentos débito não pode ser parcelados.');
    }

    return StonePaymentsPlatform.instance.payment(
      value: value,
      typeTransaction: typeTransaction,
      installment: installment,
      printReceipt: printReceipt,
    );
  }

  /// Processa uma transação na plataforma da Stone.
  ///
  /// Parâmetros:
  ///
  /// * `value` (required) - Valor do pagamento. Deve ser maior que zero.
  /// * `typeTransaction` (required) - Tipo de transação (crédito ou débito).
  /// * `installment` (optional) - Número de parcelas (padrão é 1). Deve ser maior que zero e menor que 13.
  /// * `printReceipt` (optional) - Opção para imprimir o comprovante (padrão é nulo).
  /// * `onPixQrCode` (optional) - Função de retorno para tratar o QR Code do PIX.
  ///
  /// Retorna:
  ///
  /// * Uma `Future<Transaction?>` com o objeto da transação. O valor pode ser nulo em caso de erro.
  static Future<Transaction?> transaction({
    required double value,
    required TypeTransactionEnum typeTransaction,
    int installment = 1,
    bool? printReceipt,
    ValueChanged<String>? onPixQrCode,
  }) {
    assert(value > 0, 'O valor do pagamento deve ser maior que zero.');
    assert(
      installment > 0 && installment < 13,
      'O número de parcelas deve ser maior que zero e menor que 13.',
    );
    if (typeTransaction == TypeTransactionEnum.debit) {
      assert(installment == 1, 'Pagamentos débito não pode ser parcelados.');
    }

    return StonePaymentsPlatform.instance.transaction(
      value: value,
      typeTransaction: typeTransaction,
      installment: installment,
      printReceipt: printReceipt,
      onPixQrCode: onPixQrCode,
    );
  }

  /// Ativação do SDK da Stone Payments.
  ///
  /// Parâmetros:
  ///
  /// * `appName` (required) - Nome do aplicativo.
  /// * `stoneCode` (required) - Código da Stone.
  /// * `qrCodeProviderId` (optional) - ID do provedor do QR Code.
  /// * `qrCodeAuthorization` (optional) - Autorização do QR Code.
  ///
  /// Retorna:
  ///
  /// * Uma `Future<String?>` com o status da ativação. O valor pode ser nulo em caso de erro.
  static Future<String?> activateStone({
    required String appName,
    required String stoneCode,
    String? qrCodeProviderId,
    String? qrCodeAuthorization,
  }) {
    return StonePaymentsPlatform.instance.activateStone(
      appName: appName,
      stoneCode: stoneCode,
      qrCodeProviderId: qrCodeProviderId,
      qrCodeAuthorization: qrCodeAuthorization,
    );
  }

  /// Imprime um arquivo a partir de uma lista de textos e imagens.
  ///
  /// Parâmetros:
  ///
  /// * `items` (required) - Lista de itens a serem impressos.
  ///
  /// Retorna:
  ///
  /// * Uma `Future<String?>` com o status da impressão. O valor pode ser nulo em caso de erro.
  static Future<String?> print(List<ItemPrintModel> items) {
    return StonePaymentsPlatform.instance.print(items);
  }

  /// Retorna um [StreamSubscription] que escuta as mensagens da plataforma da Stone.
  ///
  /// Parâmetros:
  ///
  /// * `onMessage` - Função de retorno para tratar as mensagens da plataforma da Stone.
  /// * `cancelOnError` (optional) - Se definido como true, o [StreamSubscription] será cancelado em caso de erro.
  /// * `onDone` (optional) - Função de retorno para lidar com a conclusão da transmissão.
  /// * `onError` (optional) - Função de retorno para lidar com erros no stream.
  ///
  /// Retorna:
  ///
  /// * Uma função que retorna um [StreamSubscription<String>] para escutar as mensagens da plataforma da Stone.
  static StreamSubscription<String> Function(
    ValueChanged<String>?, {
    bool? cancelOnError,
    VoidCallback? onDone,
    Function? onError,
  }) get onMessageListener => StonePaymentsPlatform.instance.onMessage.listen;

  /// Imprime o comprovante de pagamento.
  ///
  /// Parâmetros:
  ///
  /// * `type` (required) - Tipo de via a ser impresso, do cliente ou do estabelecimento.
  ///
  /// Retorna:
  ///
  /// * Uma `Future<String?>` com o status da impressão. O valor pode ser nulo em caso de erro.
  static Future<String?> printReceipt(TypeOwnerPrintEnum type) {
    return StonePaymentsPlatform.instance.printReceipt(type);
  }

  /// Aborta a transação atual.
  ///
  static Future<String?> abortPayment() {
    return StonePaymentsPlatform.instance.abortPayment();
  }

  /// Cancela um pagamento com a chave da transação definido pela sua aplicação.
  ///
  /// Parâmetros:
  ///
  /// * `initiatorTransactionKey` (required) - Chave da transação definida pela sua aplicação.
  /// * `printReceipt` (optional) - Opção para imprimir o comprovante (padrão é nulo).
  ///
  /// Retorna:
  ///
  /// * Uma `Future<Transaction?>` com o objeto da transação. O valor pode ser nulo em caso de erro.
  static Future<Transaction?> cancelPayment({
    required String initiatorTransactionKey,
    bool? printReceipt,
  }) {
    assert(initiatorTransactionKey != "", 'A chave da transação deve ser válida.');

    return StonePaymentsPlatform.instance.cancelPayment(
      initiatorTransactionKey: initiatorTransactionKey,
      printReceipt: printReceipt,
    );
  }

  // /// Cancela um pagamento com a chave da transação do adquirente.
  // ///
  // /// Parâmetros:
  // ///
  // /// * `acquirerTransactionKey` (required) - Chave da transação do adquirente.
  // /// * `printReceipt` (optional) - Opção para imprimir o comprovante (padrão é nulo).
  // ///
  // /// Retorna:
  // ///
  // /// * Uma `Future<Transaction?>` com o objeto da transação. O valor pode ser nulo em caso de erro.
  // static Future<Transaction?> cancelPaymentWithATK({
  //   required String acquirerTransactionKey,
  //   bool? printReceipt,
  // }) {
  //   assert(acquirerTransactionKey != "", 'A chave de transação do adquirente deve ser válida.');

  //   return StonePaymentsPlatform.instance.cancelPaymentWithATK(
  //     acquirerTransactionKey: acquirerTransactionKey,
  //     printReceipt: printReceipt,
  //   );
  // }

  /// Cancela um pagamento com o authorizationCode.
  ///
  /// Parâmetros:
  ///
  /// * `authorizationCode` (required) - Código de autorização da transação.
  /// * `printReceipt` (optional) - Opção para imprimir o comprovante (padrão é nulo).
  ///
  /// Retorna:
  ///
  /// * Uma `Future<Transaction?>` com o objeto da transação. O valor pode ser nulo em caso de erro.
  static Future<Transaction?> cancelPaymentWithAuthorizationCode({
    required String authorizationCode,
    bool? printReceipt,
  }) {
    assert(authorizationCode != "", 'O código de autorização deve ser válido.');

    return StonePaymentsPlatform.instance.cancelPaymentWithAuthorizationCode(
      authorizationCode: authorizationCode,
      printReceipt: printReceipt,
    );
  }
}
