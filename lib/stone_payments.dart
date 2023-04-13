import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:stone_payments/enums/type_owner_print_enum.dart';

import 'enums/type_transaction_enum.dart';
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
  Future<String?> payment({
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

    return StonePaymentsPlatform.instance.payment(
      value: value,
      typeTransaction: typeTransaction,
      installment: installment,
      printReceipt: printReceipt,
    );
  }

  /// Ativação do SDK da Stone Payments.
  ///
  /// Parâmetros:
  ///
  /// * `appName` (required) - Nome do aplicativo.
  /// * `stoneCode` (required) - Código da Stone.
  ///
  /// Retorna:
  ///
  /// * Uma `Future<String?>` com o status da ativação. O valor pode ser nulo em caso de erro.
  Future<String?> activateStone({
    required String appName,
    required String stoneCode,
  }) {
    return StonePaymentsPlatform.instance.activateStone(
      appName: appName,
      stoneCode: stoneCode,
    );
  }

  /// Imprime um arquivo a partir de uma imagem em Base64.
  ///
  /// Parâmetros:
  ///
  /// * `imgBase64` (required) - String com a imagem em Base64.
  ///
  /// Retorna:
  ///
  /// * Uma `Future<String?>` com o status da impressão. O valor pode ser nulo em caso de erro.
  Future<String?> printFile(String imgBase64) {
    return StonePaymentsPlatform.instance.printFile(imgBase64);
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
  StreamSubscription<String> Function(
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
  Future<String?> printReceipt(TypeOwnerPrintEnum type) {
    return StonePaymentsPlatform.instance.printReceipt(type);
  }

  Future printLineToLine(List<String> lines) {
    return StonePaymentsPlatform.instance.printLineToLine(lines);
  }
}
