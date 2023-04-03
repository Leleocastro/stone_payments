Language: [Português](../../README.md) | [English](README.md)

# Stone Payment Machine Integration Package for Flutter
This package is a plugin for Flutter that provides integration with the payment machines of the Stone company. With this package, you can easily process payments from your Flutter app using Stone's payment machines.

### Installation
To use this package, add `stone_payments` as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  stone_payments: ^0.1.0
```
Then, run `flutter pub get` to install the package.

Include in the file **local.properties**, located in the root of the project, the variable below with your token:
```
packageCloudReadToken=YOUR_TOKEN
```

The minSdkVersion must be equal or greater than 23

```
minSdkVersion=23
```

### Usage
To use the Stone Payment Machine integration in your Flutter app, you need to follow these steps:

#### 1. Create an instance of the StonePayments class
```dart
final stonePayments = StonePayments();
```
#### 2. Activate the payment machine
```dart
await stonePayments.activateStone(
    appName: 'My App',
    stoneCode: '12345678', // The code get with the Stone team
);
```
#### 3. Start a payment transaction
```dart
final transactionResult = await stonePayments.payment(
    value: 5,
    typeTransaction: TypeTransactionEnum.debit,
    installments: 1, // optional
    printReceipt: false, // optional: Print the receipt of Merchant
);
```
#### 4. Status of the transaction
```dart
stonePaymentsPlugin.onMessageListener((message) {
    setState(() {
        text = message;
    });
});
```
#### 5. Print image in Base64
```dart
await stonePaymentsPlugin.printFile(imgBase64);
```

## Example
```dart
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stone_payments/enums/type_transaction_enum.dart';
import 'package:stone_payments/stone_payments.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final stonePaymentsPlugin = StonePayments();
  await stonePaymentsPlugin.activateStone(
    appName: 'My App',
    stoneCode: '12345678',
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final stonePaymentsPlugin = StonePayments();
  String text = 'Running';
  late StreamSubscription<String> listen;

  @override
  void initState() {
    listen = stonePaymentsPlugin.onMessageListener((message) {
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
                    await stonePaymentsPlugin.payment(
                      value: 5,
                      typeTransaction: TypeTransactionEnum.debit,
                      
                    );
                  } catch (e) {
                    listen.pause();
                    setState(() {
                      text = "Falha no pagamento";
                    });
                  }
                },
                child: const Text('Comprar R\$5,00'),
              ),
              Image.asset('assets/flutter5786.png'),
              ElevatedButton(
                onPressed: () async {
                  try {
                    var byteData =
                        await rootBundle.load('assets/flutter5786.png');
                    var imgBase64 = base64Encode(byteData.buffer.asUint8List());

                    await stonePaymentsPlugin.printFile(imgBase64);
                  } catch (e) {
                    setState(() {
                      text = "Falha na impressão";
                    });
                  }
                },
                child: const Text('Imprimir Logo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### Documentation
You can learn more about the SDK [here](http://sdkandroid.stone.com.br/).