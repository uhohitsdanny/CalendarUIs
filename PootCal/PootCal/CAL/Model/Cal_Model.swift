//
//  Cal_Model.swift
//  PootCal
//
//  Created by Poot Danny on 2/12/18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation

class CalendarDates {
    
    private var datesSelected: [String]?
    private var datesPending: [String]?
    
    var datesToBeProcessed: [String]? {
        get {
            return datesSelected
        }
    }
    
    func saveSelectedDay(_ selectedday: String) {
        datesSelected?.append(selectedday)
    }
}
