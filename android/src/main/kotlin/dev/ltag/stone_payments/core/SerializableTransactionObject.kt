package dev.ltag.stone_payments.core

import br.com.stone.payment.domain.datamodel.TransAppSelectedInfo
import stone.application.enums.CardBrandEnum
import stone.application.enums.EntryMode
import stone.application.enums.InstalmentTransactionEnum
import stone.application.enums.TransactionStatusEnum
import stone.application.enums.TypeOfTransactionEnum
import stone.application.xml.enums.InstalmentTypeEnum
import stone.database.transaction.TransactionObject
import stone.user.UserModel
import java.util.Date


data class SerializableTransactionObject(
    val idFromBase: Int = 0,
    val amount: String? = null,
    val requestId: String? = null,
    val emailSent: String? = null,
    val timeToPassTransaction: String? = null,
    val initiatorTransactionKey: String? = null,
    val acquirerTransactionKey: String? = null,
    val cardHolderNumber: String? = null,
    val cardHolderName: String? = null,
    val date: String? = null,
    val time: String? = null,
    val aid: String? = null,
    val arcq: String? = null,
    val authorizationCode: String? = null,
    val iccRelatedData: String? = null,
    val transactionReference: String? = null,
    val actionCode: String? = null,
    val commandActionCode: String? = null,
    val pinpadUsed: String? = null,
    val saleAffiliationKey: String? = null,
    val cne: String? = null,
    val cvm: String? = null,
    val balance: String? = null,
    val serviceCode: String? = null,
    val subMerchantCategoryCode: String? = null,
    val entryMode: EntryMode? = null,
    val cardBrand: CardBrandEnum? = null,
    val cardBrandName: String? = null,
    val cardBrandId: Int = 0,
    val instalmentTransaction: InstalmentTransactionEnum? = null,
    val transactionStatus: TransactionStatusEnum? = TransactionStatusEnum.UNKNOWN,
    val instalmentType: InstalmentTypeEnum? = null,
    val typeOfTransactionEnum: TypeOfTransactionEnum? = null,
    val cancellationDate: Date? = null,
    val capture: Boolean? = true,
    val shortName: String? = null,
    val subMerchantAddress: String? = null,
    val userModel: UserModel? = null,
    val cvv: String? = null,
    val isFallbackTransaction: Boolean = false,
    val subMerchantCity: String? = null,
    val subMerchantTaxIdentificationNumber: String? = null,
    val subMerchantRegisteredIdentifier: String? = null,
    val subMerchantPostalAddress: String? = null,
    val appLabel: String? = null,
    val transAppSelectedInfo: TransAppSelectedInfo? = null,
    val cardExpireDate: String? = null,
    val cardSequenceNumber: String? = null,
    val externalId: String? = null,
    val qualifiers: Set<String> = HashSet(),
) {
    companion object {
        fun from(transaction: TransactionObject): SerializableTransactionObject {
            return SerializableTransactionObject(
                idFromBase = transaction.idFromBase,
                amount = transaction.amount,
                requestId = transaction.requestId,
                emailSent = transaction.emailSent,
                timeToPassTransaction = transaction.timeToPassTransaction,
                initiatorTransactionKey = transaction.initiatorTransactionKey,
                acquirerTransactionKey = transaction.acquirerTransactionKey,
                cardHolderNumber = transaction.cardHolderNumber,
                cardHolderName = transaction.cardHolderName,
                date = transaction.date,
                time = transaction.time,
                aid = transaction.aid,
                arcq = transaction.arcq,
                authorizationCode = transaction.authorizationCode,
                iccRelatedData = transaction.iccRelatedData,
                transactionReference = transaction.transactionReference,
                actionCode = transaction.actionCode,
                commandActionCode = transaction.commandActionCode,
                pinpadUsed = transaction.pinpadUsed,
                saleAffiliationKey = transaction.saleAffiliationKey,
                cne = transaction.cne,
                cvm = transaction.cvm,
                balance = transaction.balance,
                serviceCode = transaction.serviceCode,
                subMerchantCategoryCode = transaction.subMerchantCategoryCode,
                entryMode = transaction.entryMode,
                cardBrand = transaction.cardBrand,
                cardBrandName = transaction.cardBrandName,
                cardBrandId = transaction.cardBrandId,
                instalmentTransaction = transaction.instalmentTransaction,
                transactionStatus = transaction.transactionStatus,
                instalmentType = transaction.instalmentType,
                typeOfTransactionEnum = transaction.typeOfTransactionEnum,
                cancellationDate = transaction.cancellationDate,
                shortName = transaction.shortName,
                subMerchantAddress = transaction.subMerchantAddress,
                userModel = transaction.userModel,
                cvv = transaction.cvv,
                isFallbackTransaction = transaction.isFallbackTransaction,
                subMerchantCity = transaction.subMerchantCity,
                subMerchantTaxIdentificationNumber = transaction.subMerchantTaxIdentificationNumber,
                subMerchantRegisteredIdentifier = transaction.subMerchantRegisteredIdentifier,
                subMerchantPostalAddress = transaction.subMerchantPostalAddress,
                appLabel = transaction.appLabel,
                transAppSelectedInfo = transaction.transAppSelectedInfo,
                cardExpireDate = transaction.cardExpireDate,
                cardSequenceNumber = transaction.cardSequenceNumber,
                externalId = transaction.externalId,
                qualifiers = transaction.qualifiers,
            )
        }
    }
}
