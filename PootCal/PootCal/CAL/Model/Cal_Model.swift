//
//  Cal_Model.swift
//  PootCal
//
//  Created by Poot Danny on 2/12/18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation

var cal_MV: CAL_VC? = nil

protocol CAL_MC_PAR {
    var sts:CAL_DISPLAY { get }
}

class CAL_MC: CAL_MC_PAR {
    
    private var cSts: CAL_DISPLAY?
    private var datesSelected: [String]
    private var datesPending: [String]
    
    init(_ cSts:CAL_DISPLAY) {
        self.cSts = cSts
        self.datesSelected = []
        self.datesPending = ["2018 02 26", "2018 02 27", "2018 02 28"]
    }
    
    var sts: CAL_DISPLAY {
        return self.cSts!
    }

}

//****************************
extension CAL_MC {
    
    func saveSelectedDay(_ selectedday: String) {
        self.datesSelected.append(selectedday)
    }
    
    func removeDeselectedDay(_ deselectedday: String) {
        let index = self.datesSelected.index(of: deselectedday)
        self.datesSelected.remove(at: index!)
    }
    
    func getPendingDays() -> [String] {
        return self.datesPending
    }
    
    func getSelectedDays() -> [String] {
        return self.datesSelected
    }
    
    func processSelectedDates() {
        // database queries and requests
    }
}
