import 'package:stone_payments/enums/item_print_type_enum.dart';

/// ItemPrintModel
class ItemPrintModel {
  /// Type of the item print
  final ItemPrintTypeEnum type;

  /// Data of the item print
  final String data;

  /// Constructor
  const ItemPrintModel({
    required this.type,
    required this.data,
  });

  /// Generate a map from the object
  Map<String, dynamic> toMap() {
    return {
      'type': type.value,
      'data': data,
    };
  }
}
