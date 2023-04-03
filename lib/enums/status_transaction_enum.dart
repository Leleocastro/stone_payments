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
  UNKNOWN("Ocorreu um erro antes de ser enviada para o autorizador."),
  APPROVED("Transação aprovada com sucesso."),
  DECLINED("Transação negada."),
  DECLINED_BY_CARD("Transação negada pelo cartão."),
  CANCELLED("Transação cancelada."),
  PARTIAL_APPROVED("Transação foi parcialmente aprovada."),
  TECHNICAL_ERROR("Erro técnico."),
  REJECTED("Transação rejeitada."),
  WITH_ERROR("Transação não completada com sucesso."),
  PENDING("A transação está em andamento."),
  REVERSED("A transação foi cancelada automaticamente."),
  PENDING_REVERSAL("Transação foi interrompida."),
  TRANSACTION_WAITING_CARD("Aproxime, insira ou passe o cartão."),
  TRANSACTION_WAITING_PASSWORD("Aguardando a senha do cartão."),
  TRANSACTION_SENDING("Enviando a transação."),
  TRANSACTION_REMOVE_CARD("Remova o cartão."),
  TRANSACTION_CARD_REMOVED("Cartão removido."),
  REVERSING_TRANSACTION_WITH_ERROR("Tentando reverter transação.");

  final String value;

  const StatusTransactionEnum(this.value);

  static String fromName(String name) {
    var listValues = StatusTransactionEnum.values.where((e) => e.name == name);

    if (listValues.isEmpty) {
      return name;
    } else {
      return listValues.first.value;
    }
  }
}
