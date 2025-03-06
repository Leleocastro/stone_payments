Language: [Portuguese](README.md) | [English](translation/en-US/README.md)

# Stone Payment Machine Integration Package for Flutter

This package is a Flutter plugin that provides integration with Stone's payment machines. With this package, you can easily process payments from your Flutter app using Stone's payment machines.

<div align="center" id="top">
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/c/c9/Stone_pagamentos.png/800px-Stone_pagamentos.png" alt="Stone" height=100 />
</div>
<br>

### Installation

To use this package, add `stone_payments` as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  stone_payments: ^0.1.7
```

Then, run `flutter pub get` to install the package.

Include the following variable in the **local.properties** file located at the root of your project, with your token:

```
packageCloudReadToken=YOUR_TOKEN
```

The minSdkVersion must be 23 or higher.

```
minSdkVersion=23
```

##### Note!

###### Supported Devices:

- Positivo - L400
- Positivo - L300
- Ingenico - APOS A8
- Sunmi - P2
- Gertec - GPOS700X

### Usage

To use the Stone Payment Machine integration in your Flutter app, you need to follow these steps:

#### 1. Activate the payment machine

```dart
await StonePayments.activateStone(
     appName: 'My App',
     stoneCode: '12345678', // The code obtained from the Stone team
     qrCodeProviderId: 'PROVIDER ID', // QRCODE_PROVIDERID provided by the Stone integration team, if using PIX.
     qrCodeAuthentication: 'TOKEN', // QRCODE_AUTHENTICATION provided by the Stone integration team, if using PIX.
);
```

#### 2. Start a payment transaction

```dart
final transactionResult = await StonePayments.transaction(
     value: 5,
     typeTransaction: TypeTransactionEnum.debit,
     installment: 1, // optional
     printReceipt: false, // optional: Prints the Merchant receipt
     onPixQrCode: (value) {
          setState(() {
              image = base64Decode(value);
          });
     }, // optional: Callback to receive the PIX QR Code
);
```

The `transaction` method returns a `Future<Transaction>` with the transaction result, where `Transaction` is an object with the following attributes:

```dart
class Transaction {
  final String? acquirerTransactionKey;
  final String? actionCode;
  final String? aid;
  final String? amount;
  final String? appLabel;
  final String? arcq;
  final String? authorizationCode;
  final bool? capture;
  final String? cardBrand;
  final int? cardBrandId;
  final String? cardBrandName;
  final String? cardExpireDate;
  final String? cardHolderName;
  final String? cardHolderNumber;
  final String? cardSequenceNumber;
  final String? commandActionCode;
  final String? date;
  final String? entryMode;
  final String? iccRelatedData;
  final int? idFromBase;
  final String? initiatorTransactionKey;
  final String? instalmentTransaction;
  final String? instalmentType;
  final bool? isFallbackTransaction;
  final List<String>? qualifiers;
  final String? saleAffiliationKey;
  final String? serviceCode;
  final String? time;
  final String? timeToPassTransaction;
  final TransAppSelectedInfo? transAppSelectedInfo;
  final String? transactionReference;
  final String? transactionStatus;
  final String? typeOfTransactionEnum;
}
```

```dart
class TransAppSelectedInfo {
  final String? aid;
  final int? brandId;
  final String? brandName;
  final String? cardAppLabel;
  final String? paymentBusinessModel;
  final TransactionTypeInfo? transactionTypeInfo;
}
```

```dart
class TransactionTypeInfo {
  final String? appLabel;
  final int? id;
  final String? transTypeEnum;
}
```

#### 3. Transaction Status

```dart
StonePayments.onMessageListener((message) {
   setState(() {
       text = message;
   });
});
```

#### 4. Print Text and Images

You need to pass a list of `ItemPrintModel` to the `print` method, where each item in the list is a line on the receipt, which can be text or a base64 image.
The base64 image can only have a maximum size of 380x595 pixels, according to the Stone documentation.

```dart
await StonePayments.print([
     const ItemPrintModel(
         type: ItemPrintTypeEnum.text,
         data: 'Test Title',
     ),
     const ItemPrintModel(
         type: ItemPrintTypeEnum.text,
         data: 'Test Subtitle',
     ),
     ItemPrintModel(
         type: ItemPrintTypeEnum.image,
         data: imgBase64,
     ),
  ],
);
```

## Example

```dart

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
  late StreamSubscription<String> listen;
  Uint8List? image;
  TextEditingController valueController = TextEditingController();

  ValueNotifier message = ValueNotifier<String>('Running...');
  ValueNotifier transactionSuccefull = ValueNotifier<bool>(false);
  ValueNotifier transactions = ValueNotifier<List<Transaction>>([]);

  @override
  void initState() {
    listen = StonePayments.onMessageListener((message) {
      this.message.value = message;
    });

    valueController.text = '10.00';

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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: valueController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    ],
                    decoration: const InputDecoration(
                      hintText: 'Value',
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                  ),
                ),
                Wrap(
                  children: [
                    //CREDIT
                    ElevatedButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (valueController.text.isEmpty) return;

                        if (listen.isPaused) {
                          listen.resume();
                        }

                        final valor = double.parse(valueController.text);
                        try {
                          final result = await StonePayments.transaction(
                            value: valor,
                            typeTransaction: TypeTransactionEnum.credit,
                            printReceipt: true,
                          );
                          if (result == null) return;

                          if (result.transactionStatus == "APPROVED") {
                            transactionSuccefull.value = true;
                          }
                        } catch (e) {
                          listen.pause();
                          message.value = "Payment Failed";
                        }
                      },
                      child: const Text('CREDIT'),
                    ),
                    const SizedBox(width: 10),
                    //CREDIT - 2X
                    ElevatedButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (valueController.text.isEmpty) return;

                        if (listen.isPaused) {
                          listen.resume();
                        }

                        final valor = double.parse(valueController.text);
                        try {
                          final result = await StonePayments.transaction(
                            value: valor,
                            typeTransaction: TypeTransactionEnum.credit,
                            installment: 2,
                            printReceipt: true,
                          );
                          if (result == null) return;
                          if (result.transactionStatus == "APPROVED") {
                            transactionSuccefull.value = true;
                          }
                          debugPrint(result.toJson());
                        } catch (e) {
                          listen.pause();
                          message.value = "Payment Failed";
                        }
                      },
                      child: const Text('CREDIT - 2X'),
                    ),
                    const SizedBox(width: 10),
                    //DEBIT
                    ElevatedButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (valueController.text.isEmpty) return;

                        if (listen.isPaused) {
                          listen.resume();
                        }

                        final valor = double.parse(valueController.text);
                        try {
                          final result = await StonePayments.transaction(
                            value: valor,
                            typeTransaction: TypeTransactionEnum.debit,
                            printReceipt: true,
                          );
                          if (result == null) return;
                          if (result.transactionStatus == "APPROVED") {
                            transactionSuccefull.value = true;
                          }
                          debugPrint(result.toJson());
                        } catch (e) {
                          listen.pause();
                          message.value = "Payment Failed";
                        }
                      },
                      child: const Text('DEBIT'),
                    ),
                    const SizedBox(width: 10),
                    //PIX
                    ElevatedButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (valueController.text.isEmpty) return;

                        if (listen.isPaused) {
                          listen.resume();
                        }

                        final valor = double.parse(valueController.text);
                        try {
                          final result = await StonePayments.transaction(
                            value: valor,
                            typeTransaction: TypeTransactionEnum.pix,
                            printReceipt: true,
                            onPixQrCode: (String value) async {
                              final qrCodeBase64 = value.replaceAll('\n', '');
                              final bytes = base64Decode(qrCodeBase64);
                              setState(() {
                                image = bytes;
                              });
                            },
                          );
                          if (result == null) return;
                          if (result.transactionStatus == "APPROVED") {
                            transactionSuccefull.value = true;
                          }
                          debugPrint(result.toJson());
                        } catch (e) {
                          listen.pause();
                          message.value = "Payment Failed";
                        }
                      },
                      child: const Text('PIX'),
                    ),
                  ],
                ),
                //ABORT TRANSACTION
                ElevatedButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    if (valueController.text.isEmpty) return;

                    if (listen.isPaused) {
                      listen.resume();
                    }

                    try {
                      final result = await StonePayments.abortPayment();
                      if (result == null) return;
                      debugPrint(result.toString());
                    } catch (e) {
                      listen.pause();
                      message.value = "Abort Transaction Failed";
                    }
                  },
                  child: const Text('ABORT TRANSACTION'),
                ),

                if (image != null)
                  Image.memory(
                    image!,
                    height: 100,
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(width: 100, 'assets/flutter5786.png'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      var byteData =
                          await rootBundle.load('assets/flutter5786.png');
                      var imgBase64 =
                          base64Encode(byteData.buffer.asUint8List());

                      var items = [
                        const ItemPrintModel(
                          type: ItemPrintTypeEnum.text,
                          data: 'Test Title',
                        ),
                        const ItemPrintModel(
                          type: ItemPrintTypeEnum.text,
                          data: 'Test Subtitle',
                        ),
                        ItemPrintModel(
                          type: ItemPrintTypeEnum.image,
                          data: imgBase64,
                        ),
                        if (image != null)
                          ItemPrintModel(
                            type: ItemPrintTypeEnum.image,
                            data: base64Encode(image!.toList()),
                          ),
                      ];

                      await StonePayments.print(items);
                    } catch (e) {
                      message.value = "Payment Failed";
                    }
                  },
                  child: const Text('Print Test'),
                ),
                   ValueListenableBuilder(
                      valueListenable: transactionSuccefull,
                      builder: (context, transactionSuccefull, child) {
                        if (transactionSuccefull) {
                          return ElevatedButton(
                            onPressed: () async {
                              try {
                                await StonePayments.printReceipt(
                                    TypeOwnerPrintEnum.client);
                              } catch (e) {
                                message.value = "Payment Failed";
                              }
                            },
                            child: const Text('Print Client Receipt'),
                          );
                        }
                        return const SizedBox();
                      }),
                const SizedBox(height: 20),
                const Text('Return Message:'),
                ValueListenableBuilder(
                    valueListenable: message,
                    builder: (context, message, child) {
                      return Text(message.toString());
                    }),
                ValueListenableBuilder(
                    valueListenable: transactions,
                    builder: (context, _transactions, child) {
                      if (_transactions.isEmpty) return const SizedBox();

                      return Column(
                        children:[
                          const SizedBox(height: 20),
                          const Text('Transactions:'),
                          ..._transactions
                              .map((transaction) => ListTile(
                                    title: Text(transaction
                                        .initiatorTransactionKey
                                        .toString()),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () async {
                                        final result =
                                            await StonePayments.cancelPayment(
                                                initiatorTransactionKey:
                                                    transaction
                                                        .initiatorTransactionKey!,
                                                printReceipt: true);
                                        if (result == null) return;
                                        if (result.transactionStatus ==
                                            "CANCELLED") {
                                          transactionSuccefull.value = true;
                                          transactions.value
                                              .remove(transaction);
                                          transactions.notifyListeners();
                                        }
                                        debugPrint(result.toJson());
                                      },
                                    ),
                                  ))
                              .toList()
                        ],
                      );
                    }),
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}

```

### Stone Documentation

You can learn more about the SDK [here](https://sdkandroid.stone.com.br/).

## Author

This project was developed by:

<div> 
<a href="https://github.com/leleocastro">
  <img src="https://avatars.githubusercontent.com/u/24722339?s=80&u=6a5799c2aba4bb6b256a2d2e88fbda6b2d317643&v=4" height=90 />
</a>
<br/>
<a href="https://github.com/leleocastro" target="_blank">Leonardo Castro</a>
</div>

&#xa0;

<a href="#top">Back to top</a>

## Unofficial package!
