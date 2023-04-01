// ignore_for_file: constant_identifier_names

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
