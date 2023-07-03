//
//  String+extension.swift
//  VinmoApp
//
//  Created by asif hussain on 3/19/23.
//

import Foundation
extension String {
    static func getString(_ message: Any?) -> String {
        if let string = message {
            guard let strMessage = string as? String else {
                guard let doubleValue = string as? Double else {
                    guard let intValue = string as? Int else {
                        guard string is Float else {
                            guard let int64Value = string as? Int64 else {
                                guard let int32Value = string as? Int32 else {
                                    guard let int16Value = string as? Int32 else {
                                        return ""
                                    }
                                    return String(int16Value)
                                }
                                return String(int32Value)
                            }
                            return String(int64Value)
                        }
                        return String(format: "%.2f", string as! Float)
                    }
                    return String(intValue)
                }
                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 0
                formatter.maximumFractionDigits = 2
                formatter.minimumIntegerDigits = 1
                guard let formattedNumber = formatter.string(from: NSNumber(value: doubleValue)) else {
                    return ""
                }
                return formattedNumber
            }
            return strMessage
        }
        return ""
    }
  
    
}
