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
    private var datesSelected: [String] = [String()]
    private var datesPending: [String]?
    
    init(_ cSts:CAL_DISPLAY) {
        self.cSts = cSts
    }
    
    var sts: CAL_DISPLAY {
        return self.cSts!
    }
    
    func saveSelectedDay(_ selectedday: String) {
        self.datesSelected.append(selectedday)
    }
    
    func getSelectedDays() -> [String]? {
        return self.datesSelected
    }
}

extension CAL_MC {
    
    //
    
}
