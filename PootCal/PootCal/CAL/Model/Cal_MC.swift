//
//  Cal_Model.swift
//  PootCal
//
//  Created by Poot Danny on 2/12/18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation

var cal_MV: CAL_MV? = nil

protocol CAL_MC_PAR {
    var sts:CAL_DISPLAY { get }
}

class CAL_MC: CAL_MC_PAR {
    
    private var cSts: CAL_DISPLAY?
    private var datesSelected: [String]
    private var datesPending: [String]
    private var unavailableDates: [String]
    
    init(_ cSts:CAL_DISPLAY) {
        self.cSts = cSts
        self.datesSelected = []
        self.datesPending = ["2018 03 27", "2018 03 28"]
        self.unavailableDates = ["2018 03 17", "2018 03 18"]
    }
    
    var sts: CAL_DISPLAY {
        return self.cSts!
    }

}

//*****************************
// Functions for SELECTING mode
extension CAL_MC {
    
    func saveSelectedDay(_ selectedday: String) {
        self.datesSelected.append(selectedday)
    }
    
    func removeDeselectedDay(_ deselectedday: String) {
        let index = self.datesSelected.index(of: deselectedday)
        if index != nil {
            self.datesSelected.remove(at: index!)
        }
    }
    
    func getSelectedDays() -> [String] {
        return self.datesSelected
    }
    
    func processSelectedDates() {
        // Will send the selected days to the matchmaking algorithm
        // and interact with the database
        // TO DO: pass data to the matchmaking algorithm
    }
}

//****************************
// Functions for DISPLAYING STATUS mode
extension CAL_MC {
    
    func getPendingDays() -> [String] {
        // Will query the database for pending days
        // TO DO: create requests to the database
        return self.datesPending
    }
    
    func getUnavailableDays() -> [String] {
        return self.unavailableDates
    }
}
