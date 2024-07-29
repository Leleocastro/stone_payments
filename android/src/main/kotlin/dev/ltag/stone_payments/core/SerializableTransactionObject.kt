//package dev.ltag.stone_payments.core
//
//import kotlinx.serialization.Serializable
//import stone.database.transaction.TransactionObject
//
//@Serializable
//class SerializableTransactionObject : TransactionObject() {}
//
//fun convertToSerializable(transaction: TransactionObject): SerializableTransactionObject {
//    val serializableTransaction = SerializableTransactionObject()
//
//
//    serializableTransaction.idFromBase = transaction.idFromBase
//    serializableTransaction.amount = transaction.amount
//    serializableTransaction.emailSent = transaction.emailSent
//    serializableTransaction.timeToPassTransaction = transaction.timeToPassTransaction
//    serializableTransaction.initiatorTransactionKey = transaction.initiatorTransactionKey
//    serializableTransaction.acquirerTransactionKey = transaction.acquirerTransactionKey
//    serializableTransaction.cardHolderNumber = transaction.cardHolderNumber
//    serializableTransaction.cardHolderName = transaction.cardHolderName
//    serializableTransaction.date = transaction.date
//    serializableTransaction.time = transaction.time
//    serializableTransaction.aid = transaction.aid
//    serializableTransaction.arcq = transaction.arcq
//    serializableTransaction.authorizationCode = transaction.authorizationCode
//    serializableTransaction.iccRelatedData = transaction.iccRelatedData
//    serializableTransaction.transactionReference = transaction.transactionReference
//    serializableTransaction.actionCode = transaction.actionCode
//    serializableTransaction.commandActionCode = transaction.commandActionCode
//    serializableTransaction.pinpadUsed = transaction.pinpadUsed
//    serializableTransaction.saleAffiliationKey = transaction.saleAffiliationKey
//    serializableTransaction.cne = transaction.cne
//    serializableTransaction.cvm = transaction.cvm
//    serializableTransaction.balance = transaction.balance
//    serializableTransaction.serviceCode = transaction.serviceCode
//    serializableTransaction.subMerchantCategoryCode = transaction.subMerchantCategoryCode
//    serializableTransaction.entryMode = transaction.entryMode
//    serializableTransaction.cardBrandName = transaction.cardBrandName
//    serializableTransaction.cardBrandId = transaction.cardBrandId
//    serializableTransaction.instalmentTransaction = transaction.instalmentTransaction
//    serializableTransaction.transactionStatus = transaction.transactionStatus
//    serializableTransaction.instalmentType = transaction.instalmentType
//    serializableTransaction.typeOfTransactionEnum = transaction.typeOfTransactionEnum
//    serializableTransaction.signature = transaction.signature
//    serializableTransaction.cancellationDate = transaction.cancellationDate
//    serializableTransaction.isCapture = transaction.isCapture
//    serializableTransaction.shortName = transaction.shortName
//    serializableTransaction.subMerchantAddress = transaction.subMerchantAddress
//    serializableTransaction.userModel = transaction.userModel
//    serializableTransaction.cvv = transaction.cvv
//    serializableTransaction.isFallbackTransaction = transaction.isFallbackTransaction
//    serializableTransaction.subMerchantCity = transaction.subMerchantCity
//    serializableTransaction.subMerchantTaxIdentificationNumber = transaction.subMerchantTaxIdentificationNumber
//    serializableTransaction.subMerchantRegisteredIdentifier = transaction.subMerchantRegisteredIdentifier
//    serializableTransaction.subMerchantPostalAddress = transaction.subMerchantPostalAddress
//    serializableTransaction.appLabel = transaction.appLabel
//    serializableTransaction.transAppSelectedInfo = transaction.transAppSelectedInfo
//    serializableTransaction.cardExpireDate = transaction.cardExpireDate
//    serializableTransaction.cardSequenceNumber = transaction.cardSequenceNumber
//    serializableTransaction.externalId = transaction.externalId
//    serializableTransaction.qualifiers.addAll(transaction.qualifiers)
//    serializableTransaction.qrCode = transaction.qrCode
//
//    return serializableTransaction
//}
