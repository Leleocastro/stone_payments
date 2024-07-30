import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stone_payments/enums/item_print_type_enum.dart';
import 'package:stone_payments/enums/type_owner_print_enum.dart';
import 'package:stone_payments/enums/type_transaction_enum.dart';
import 'package:stone_payments/models/item_print_model.dart';
import 'package:stone_payments/stone_payments.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StonePayments.activateStone(
    appName: 'My App',
    stoneCode: '12345678',
    qrCodeAuthorization: 'TOKEN',
    qrCodeProviderId: 'PROVIDER_ID',
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String text = 'Running';
  late StreamSubscription<String> listen;
  Uint8List? image;

  @override
  void initState() {
    listen = StonePayments.onMessageListener((message) {
      setState(() {
        text = message;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(text),
                ElevatedButton(
                  onPressed: () async {
                    if (listen.isPaused) {
                      listen.resume();
                    }
                    try {
                      final result = await StonePayments.transaction(
                        value: 5,
                        typeTransaction: TypeTransactionEnum.pix,
                        onPixQrCode: (value) {
                          setState(() {
                            image = base64Decode(value);
                          });
                        },
                      );
                      print(result);
                    } catch (e) {
                      listen.pause();
                      setState(() {
                        text = "Falha no pagamento";
                      });
                    }
                  },
                  child: const Text('Comprar'),
                ),
                if (image != null)
                  Image.memory(
                    image!,
                    height: 200,
                  ),
                Image.asset('assets/flutter5786.png'),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      var byteData = await rootBundle.load('assets/flutter5786.png');
                      var imgBase64 = base64Encode(byteData.buffer.asUint8List());

                      var items = [
                        const ItemPrintModel(
                          type: ItemPrintTypeEnum.text,
                          data: 'Teste Título',
                        ),
                        const ItemPrintModel(
                          type: ItemPrintTypeEnum.text,
                          data: 'Teste Subtítulo',
                        ),
                        ItemPrintModel(
                          type: ItemPrintTypeEnum.image,
                          data: imgBase64,
                        ),
                      ];

                      await StonePayments.print(items);
                    } catch (e) {
                      setState(() {
                        text = "Falha na impressão";
                      });
                    }
                  },
                  child: const Text('Imprimir'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await StonePayments.printReceipt(TypeOwnerPrintEnum.merchant);
                    } catch (e) {
                      setState(() {
                        text = "Falha na impressão";
                      });
                    }
                  },
                  child: const Text('Imprimir Via Loja'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await StonePayments.printReceipt(TypeOwnerPrintEnum.client);
                    } catch (e) {
                      setState(() {
                        text = "Falha na impressão";
                      });
                    }
                  },
                  child: const Text('Imprimir Via Cliente'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
