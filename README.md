Idioma: [Português](README.md) | [English](translation/en-US/README.md)

# Pacote de Integração da Máquina de Pagamento Stone para Flutter
Este pacote é um plugin para Flutter que fornece integração com as máquinas de pagamento da empresa Stone. Com este pacote, você pode facilmente processar pagamentos de seu aplicativo Flutter usando as máquinas de pagamento da Stone.

![image](https://lh3.googleusercontent.com/YNkfDrnWzNdaFniogLACqRZKkc9fuV9pLYlVNQ7q_1WcH5tV_4NF_yLhR9Of8ulNpzorgnTpqpLWQWSWdtg7QWJBh3zI8zNnnb-DEDLEN2VHbnrwYYiM52_RooZ6togiTjVpBDWx)

### Instalação
Para usar este pacote, adicione `stone_payments` como uma dependência em seu arquivo `pubspec.yaml`.

```yaml
dependencies:
   stone_payments: ^0.1.0
```
Em seguida, execute `flutter pub get` para instalar o pacote.

Inclua no arquivo **local.properties**, localizado na raiz do projeto, a variável abaixo com seu token:
```
pacoteCloudReadToken=SEU_TOKEN
```

O minSdkVersion deve ser igual ou maior que 23

```
minSdkVersion=23
```

Adicione o maven da Stone, conforme abaixo, no build.gradle do projeto dentro de allProjects > repositories:
```gradle
allprojects {
    repositories {
        google()
        mavenCentral()

        maven { url "https://packagecloud.io/priv/${packageCloudReadToken}/stone/pos-android/maven2" }
    }
}
```

### Uso
Para usar a integração da Stone Payment Machine em seu aplicativo Flutter, você precisa seguir estas etapas:

#### 1. Crie uma instância da classe StonePayments
```dart
final stonePayments = StonePayments();
```
#### 2. Ative a máquina de pagamento
```dart
await stonePayments.activateStone(
     appName: 'Meu aplicativo',
     stoneCode: '12345678', // O código obtido com a equipe da Stone
);
```
#### 3. Inicie uma transação de pagamento
```dart
final transactionResult = await stonePayments.payment(
     valor: 5,
     typeTransaction: TypeTransactionEnum.debit,
     parcelas: 1, // opcional
     printReceipt: false, // opcional: Imprime o recibo do Comerciante
);
```
#### 4. Status da transação
```dart
stonePaymentsPlugin.onMessageListener((mensagem) {
     setState(() {
         texto = mensagem;
     });
});
```
#### 5. Imprimir imagem em Base64
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

### Documentação
Você pode aprender mais sobre o SDK [aqui](https://sdkandroid.stone.com.br/).