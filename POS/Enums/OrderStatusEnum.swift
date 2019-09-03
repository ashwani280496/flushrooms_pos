//
//  OrderStatusEnum.swift
//  POS
//
//  Created by Djubo on 01/09/19.
//  Copyright © 2019 Djubo. All rights reserved.
//

import Foundation

enum OrderStatusEnum: Int {
    
    case OS_SETTLE = 1
    case OS_CANCEL = 2
    case OS_OPEN = 3
    case OS_PENDING_FOR_SETTLEMENT = 4
    case OS_NEW = 11
    
}

enum PaymentTypeEnum: Int {
    
    case OTHERS = 0
    case CASH = 1
    case CREDIT_CARD = 2
    case DEBIT_CARD = 3
    case QUICK_PAY = 4
    case PAYMENT_WALLLET = 5
    case NET_BANKING = 6
    case NEFT = 7
    case RTGS = 8
    case IMPS = 9
    case UPI = 10
    case USSD = 11
    case CHEQUE = 13
    case E_COLLECT = 14
}
