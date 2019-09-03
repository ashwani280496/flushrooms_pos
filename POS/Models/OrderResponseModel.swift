//
//    OrdersResponseModel.swift
//
//    Create by ASHWANI KUMAR on 5/7/2019

import Foundation


class OrdersResponseModel : Codable{
    
    var assignedTo : Int?
    var billToCompanyFlag : Bool?
   // var billingPreference : Int?
  //  var comments : String?
   // var complementaryReason : String?
   // var complementaryReasonText : String?
    var createdAt : String
    var createdBy : Int
    var date : String
    var folioId : Int?
 //   var folioNumber : String?
   // var guest : AnyObject!
    var id : Int
   // var intVersion : Long
    var invoiceDetails : InvoiceDetail!
    var isComplementary : Bool?
    var isPaid : Bool?
    var isTableReleased : Bool?
    var linkToRoom : Bool
    var multiplePrints : Bool?
    var orderItems : OrderItemObjectModel?
    var orderNumber : String
    var outletId : Int?
    var payLaterFlag : Bool?
    var payments : [PaymentModel]?
    var propertyUnitId : Int?
    var roomId : Int?
    var roomNumber : String?
    var serviceDisplayContainerId : Int?
    var status : Int
    var tokenNumber : Int?
    var totalDiscount : Double?
    var type : Int?
    var updatedAt : String?
}




class InvoiceDetail : Codable{
    
    var billAmount : Double
    var generatedBy : Int
    var generatedOn : String
    var invoiceNumber : String
    var netPayable : Double
    var netPayableByEntity : Double
    var statutoryIds : [Int]
    var toBePaidBy : Int

}



class OrderItemObjectModel : Codable{
    
    var orderItems : [OrderItem] = []
}



class OrderItem : Codable{
    
    var comments : String?
    var date : String
    var discounts : Double
    var id : Int
    var isComplementary : Bool
    var itemId : Int
    var quantity : Int
  //  var taxBreakup : TaxBreakup!
    var totalTax : Double
    var unitPrice : Double
}

class PaymentModel:Codable{
    var amount : Double
    var bankName : String?
    var cCardNumber : String?
    var cardBrand : String?
    var createdAt : String?
    var createdBy : Int?
    var createdByName : String?
    var creditLedgerId : Int?
    var creditCardId : Int?
    var currency : String?
    var date : String?
   // var entities : PaymentEntitiesModel?
   // var paymentReceived : Bool
    var sendLink : Bool?
    var folioId : Int?
    var id : Int
    var isCustomTagged : Bool?
    var isDeleted : Bool
    var lastPrintedBy : String?
    var ledgerId : Int?
   // var metaData : PaymentMetaDataModel?
    var mode : Int
    var modeName : String?
    var notes : String?
    var orderId : Int?
    var paidBy : Int?
    var paidByEntityId : Int?
    var paidByName : String?
    var paymentDebitedToId : Int?
    var pgReferenceId : String?
    var pgExternalRefId : Int?
    var receiptNumber : String?
    var source : Int?
    var staffId : Int?
    var status : Int?
    // var taxes : V5PaymentTaxes
    var transactionId : String?
    var guestEmail : String?
    var guestPhone : String?
    var autoConfirmation : Bool?
}
