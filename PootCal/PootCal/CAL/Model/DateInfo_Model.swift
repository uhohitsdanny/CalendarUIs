//
//  DateInfo_Model.swift
//  PootCal
//
//  Created by Danny Navarro on 2/25/18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation

class DateInfo_Model {
    
    private var sts: Status
    private var date: String
    
    init(_ dSts: Status,_ date: String) {
        self.sts = dSts
        self.date = date
    }
    
    func getSts() -> String {
        switch self.sts {
        case .pending:
            return "Pending"
        case .unavailable:
            return "Unavailable"
        case .confirmed:
            return "Confirmed"
        default:
            return "Pending"
        }
    }
    
    func getDate() -> String {
        return self.date
    }
    
}
