import 'package:stone_payments/enums/item_print_type_enum.dart';

class ItemPrintModel {
  final ItemPrintTypeEnum type;
  final String data;

  const ItemPrintModel({
    required this.type,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type.value,
      'data': data,
    };
  }
}
