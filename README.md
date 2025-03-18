Idioma: [Português](README.md) | [English](translation/en-US/README.md)

# Pacote de Integração da Máquina de Pagamento Stone para Flutter

Este pacote é um plugin para Flutter que fornece integração com as máquinas de pagamento da empresa Stone. Com este pacote, você pode facilmente processar pagamentos de seu aplicativo Flutter usando as máquinas de pagamento da Stone.

<div align="center" id="top"> 
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/c/c9/Stone_pagamentos.png/800px-Stone_pagamentos.png" alt="Stone" height=100 />
</div>
<br>

### Instalação

Para usar este pacote, adicione `stone_payments` como uma dependência em seu arquivo `pubspec.yaml`.

```yaml
dependencies:
  stone_payments: ^1.0.0
```

Em seguida, execute `flutter pub get` para instalar o pacote.

Inclua no arquivo **local.properties**, localizado na raiz do projeto, a variável abaixo com seu token:

```
packageCloudReadToken=SEU_TOKEN
```

O minSdkVersion deve ser igual ou maior que 23

```
minSdkVersion=23
```

##### Atenção!

###### Dipositivos Suportados:

- Positivo - L400
- Positivo - L300
- Ingenico - APOS A8
- Sunmi - P2
- Gertec - GPOS700X

### Uso

Para usar a integração da Stone Payment Machine em seu aplicativo Flutter, você precisa seguir estas etapas:

#### 1. Ative a máquina de pagamento

```dart
await StonePayments.activateStone(
     appName: 'Meu aplicativo',
     stoneCode: '12345678', // O código obtido com a equipe da Stone
     qrCodeProviderId: 'PROVIDER ID', // QRCODE_PROVIDERID fornecido pela equipe de integração da Stone, caso vá utilizar PIX.
     qrCodeAuthentication: 'TOKEN', // QRCODE_AUTHENTICATION fornecido pela equipe de integração da Stone, caso vá utilizar PIX.
);
```

#### 2. Inicie uma transação de pagamento

```dart
final transactionResult = await StonePayments.transaction(
     valor: 5,
     typeTransaction: TypeTransactionEnum.debit,
     parcelas: 1, // opcional
     printReceipt: false, // opcional: Imprime o recibo do Comerciante
     onPixQrCode: (value) {
          setState(() {
              image = base64Decode(value);
          });
     }, // opcional: Callback para receber o QRCode do PIX
);
```

O método transaction retorna um `Future<Transaction>` com o resultado da transação, sendo `Transaction` um objeto com os seguintes atributos:

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

#### 3. Status da transação

```dart
StonePayments.onMessageListener((mensagem) {
   setState(() {
       texto = mensagem;
   });
});
```

#### 4. Imprimir textos e imagens

É necessário passar uma lista com `ItemPrintModel` para o método `print`, onde cada item da lista é uma linha do recibo, podendo ser texto ou imagem em base64.
A imagem em base64 só pode ter no máximo as dimensões de 380x595 pixels, conforme a documentação da Stone.

```dart
await StonePayments.print([
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
                      hintText: 'Valor',
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                  ),
                ),
                Wrap(
                  children: [
                    //CREDITO
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
                          message.value = "Falha no pagamento";
                        }
                      },
                      child: const Text('CRÉDITO'),
                    ),
                    const SizedBox(width: 10),
                    //CREDITO - 2X
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
                          message.value = "Falha no pagamento";
                        }
                      },
                      child: const Text('CRÉDITO - 2X'),
                    ),
                    const SizedBox(width: 10),
                    //DÉBITO
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
                          message.value = "Falha no pagamento";
                        }
                      },
                      child: const Text('DÉBITO'),
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
                          message.value = "Falha no pagamento";
                        }
                      },
                      child: const Text('PIX'),
                    ),
                  ],
                ),
                //ABORTAR TRANSAÇÃO
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

                      if(result == "ABORTED") {
                        message.value = "Transação abortada com sucesso";
                      }

                      debugPrint(result.toString());
                    } catch (e) {
                      listen.pause();
                      message.value = "Falha ao abortar transação";
                    }
                  },
                  child: const Text('ABORTAR TRANSAÇÃO'),
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
                        if (image != null)
                          ItemPrintModel(
                            type: ItemPrintTypeEnum.image,
                            data: base64Encode(image!.toList()),
                          ),
                      ];

                      await StonePayments.print(items);
                    } catch (e) {
                      message.value = "Falha no pagamento";
                    }
                  },
                  child: const Text('Teste de Impressão'),
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
                            message.value = "Falha no pagamento";
                          }
                        },
                        child: const Text('Imprimir Via Cliente'),
                      );
                    }
                    return const SizedBox();
                  }),
                const SizedBox(height: 20),
                const Text('Mensagem retorno:'),
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
                        children: [
                          const SizedBox(height: 20),
                          const Text('Transações:'),
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

### Documentação Stone

Você pode aprender mais sobre o SDK [aqui](https://sdkandroid.stone.com.br/).

## Autor

Este projeto foi desenvolvido por:

<div style="display: flex; align-items: center;"> 
<div style="margin-right: 10px;">
<a href="https://github.com/leleocastro">
  <img src="https://avatars.githubusercontent.com/u/24722339?s=80&u=6a5799c2aba4bb6b256a2d2e88fbda6b2d317643&v=4" height=90 />
</a>
<br/>
<a href="https://github.com/leleocastro" target="_blank">Leonardo Castro</a>
</div>
<div style="margin-right: 10px;">
<a href="https://github.com/carvalhowesley">
  <img src="https://avatars.githubusercontent.com/u/19750283?v=4" height=90 />
</a>
<br/>
<a href="https://github.com/carvalhowesley" target="_blank">Wesley Carvalho</a>
</div>
</div>

&#xa0;

<a href="#top">Voltar para o topo</a>

## Pacote não oficial!
