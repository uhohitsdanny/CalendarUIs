//
//  Globals.swift
//  PootCal
//
//  Created by Danny Navarro on 2/16/18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation

// Determines the intended use of the calendar
// Calendar module will display different views depending on the display request
enum CAL_DISPLAY: Int {
    case selecting      = 0
    case display_sts
}

enum Status: Int {
    case selected       = 0
    case deselected
    case pending
    case unavailable
    case confirmed
}
