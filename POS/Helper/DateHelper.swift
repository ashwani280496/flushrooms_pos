//
//  DateHelper.swift
//  POS
//
//  Created by Djubo on 01/09/19.
//  Copyright © 2019 Djubo. All rights reserved.
//

import Foundation
import Foundation

class DateHelper{
    
    static let defaultDateFormat = "yyyy-MM-dd"
    static let ddMMyyyyFormat = "dd-MM-yyyy"
    static var dateTimeFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    static var serverDateTimeFormat = "yyyy-MM-dd'T'HH:mm:ss"
    static var historyDisplayDateFormat = "HH:mm '|' dd-MM-yyyy"
    
    static func getCurrentDateString(timeZone : String, format : String) -> String{
        let dateFormatter = DateFormatter.init()
        dateFormatter.timeZone = NSTimeZone.init(name: timeZone)! as TimeZone
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: Date.init())
    }
    
    static func stringToDateGenerator(dateStr: String, format: String) -> Date{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC") //Current time zone
        //according to date format your date string
        var date1=dateStr
        if dateStr.contains("."){
            date1 = String(dateStr.prefix(19))
           
        }
        guard let date = dateFormatter.date(from: date1) else {
            fatalError()
        }
        
        return date
    }
    
    static func dateToStringGenerator(date: Date, format: String) -> String{
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
        
    }
    
}
