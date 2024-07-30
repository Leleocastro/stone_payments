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
  stone_payments: ^0.1.7
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
                  child: const Text('Comprar R\$5,00'),
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
```

### Documentação Stone

Você pode aprender mais sobre o SDK [aqui](https://sdkandroid.stone.com.br/).

## Autor

Este projeto foi desenvolvido por:

<div> 
<a href="https://github.com/leleocastro">
  <img src="https://avatars.githubusercontent.com/u/24722339?s=80&u=6a5799c2aba4bb6b256a2d2e88fbda6b2d317643&v=4" height=90 />
</a>
<br/>
<a href="https://github.com/leleocastro" target="_blank">Leonardo Castro</a>
</div>

&#xa0;

<a href="#top">Voltar para o topo</a>

## Pacote não oficial!
