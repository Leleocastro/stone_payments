// ignore_for_file: constant_identifier_names

/// StatusTransactionEnum
///
/// This class is used to define the status of a transaction.
///
/// The status of a transaction is used in the following classes:
///
/// * [Transaction]
///
/// The following is the list of possible status:
///
/// * [UNKNOWN]
/// * [APPROVED]
/// * [DECLINED]
/// * [DECLINED_BY_CARD]
/// * [CANCELLED]
/// * [PARTIAL_APPROVED]
/// * [TECHNICAL_ERROR]
/// * [REJECTED]
/// * [WITH_ERROR]
/// * [PENDING]
/// * [REVERSED]
/// * [PENDING_REVERSAL]
/// * [TRANSACTION_WAITING_CARD]
/// * [TRANSACTION_WAITING_PASSWORD]
/// * [TRANSACTION_SENDING]
/// * [TRANSACTION_REMOVE_CARD]
/// * [TRANSACTION_CARD_REMOVED]
/// * [REVERSING_TRANSACTION_WITH_ERROR]
///
/// The status is used to determine the type of transaction.
///
/// For example, a transaction with the status [APPROVED] is a transaction
/// that was approved by the bank.
///
/// In the case of a transaction with the status [DECLINED], it is a transaction
/// that was not approved by the bank.
///
/// In the case of a transaction with the status [CANCELLED], it is a transaction
/// that was canceled by the user.
///
/// In the case of a transaction with the status [TECHNICAL_ERROR], it is a
/// transaction that was not completed due to a technical error.
///
/// In the case of a transaction with the status [WITH_ERROR], it is a transaction
/// that was not completed due to an error.
///
/// In the case of a transaction with the status [REJECTED], it is a transaction
/// that was rejected by the bank.
///
/// In the case of a transaction with the status [PARTIAL_APPROVED], it is a
/// transaction that was approved by the bank and has a partial value.
///
/// In the case of a transaction with the status [REVERSED], it is a transaction
/// that was automatically reversed by the bank.
///
/// In the case of a transaction with the status [PENDING], it is a transaction
/// that is in progress.
///
/// In the case of a transaction with the status [PENDING_REVERSAL],
enum StatusTransactionEnum {
  /// Ocorreu um erro antes de ser enviada para o autorizador.
  UNKNOWN("Ocorreu um erro antes de ser enviada para o autorizador."),

  /// Transação aprovada com sucesso.
  APPROVED("Transação aprovada com sucesso."),

  /// Transação negada.
  DECLINED("Transação negada."),

  /// Transação negada pelo cartão.
  DECLINED_BY_CARD("Transação negada pelo cartão."),

  /// Transação cancelada.
  CANCELLED("Transação cancelada."),

  /// Transação foi parcialmente aprovada.
  PARTIAL_APPROVED("Transação foi parcialmente aprovada."),

  /// Erro técnico.
  TECHNICAL_ERROR("Erro técnico."),

  /// Transação rejeitada.
  REJECTED("Transação rejeitada."),

  /// Transação não completada com sucesso
  WITH_ERROR("Transação não completada com sucesso."),

  /// A transação está em andamento.
  PENDING("A transação está em andamento."),

  /// A transação foi cancelada automaticamente.
  REVERSED("A transação foi cancelada automaticamente."),

  /// Transação foi interrompida.
  PENDING_REVERSAL("Transação foi interrompida."),

  /// Aproxime, insira ou passe o cartão.
  TRANSACTION_WAITING_CARD("Aproxime, insira ou passe o cartão."),

  /// Aguardando a senha do cartão.
  TRANSACTION_WAITING_PASSWORD("Aguardando a senha do cartão."),

  /// Enviando a transação.
  TRANSACTION_SENDING("Enviando a transação."),

  /// Remova o cartão.
  TRANSACTION_REMOVE_CARD("Remova o cartão."),

  /// Cartão removido.
  TRANSACTION_CARD_REMOVED("Cartão removido."),

  /// Tentando reverter transação.
  REVERSING_TRANSACTION_WITH_ERROR("Tentando reverter transação.");

  /// Values of the enum
  final String value;

  const StatusTransactionEnum(this.value);

  /// Return the name of the enum
  static String fromName(String name) {
    var listValues = StatusTransactionEnum.values.where((e) => e.name == name);

    if (listValues.isEmpty) {
      return name;
    } else {
      return listValues.first.value;
    }
  }
}
