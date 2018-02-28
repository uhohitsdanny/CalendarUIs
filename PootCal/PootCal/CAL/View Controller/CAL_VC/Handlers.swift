//
//  Handlers.swift
//  PootCal
//
//  Created by Danny Navarro on 2/27/18.
//  Copyright © 2018 User. All rights reserved.
//

import JTAppleCalendar

//                      *    Handlers    *
//
// These functions help handle some details for the setup.
//
extension CAL_VC {
    
    //
    // Grabs today's date sets up the border in the date cell
    // corresponding to the current date.
    //
    func handleCellCurrentDate(cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? DateCell else {  return  }
        self.formatter.dateFormat = "yyyy MM dd"
        
        let todaysDateStr = formatter.string(from: Date())
        let cellDateStr = formatter.string(from: cellState.date)
        
        if todaysDateStr == cellDateStr {
            //highlight border
            validCell.contentView.layer.borderWidth = 1
            validCell.contentView.layer.borderColor = UIColor.PrimaryPootColor.OceanMist.cgColor
        } else {
            validCell.contentView.layer.borderWidth = 0
        }
    }
    
    //
    // Handles the cell text color for in and out dates and the dates
    // that belong to current month in display. (The grayed dates)
    //
    func handleCellTextColor(cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? DateCell else {  return  }
        if cellState.dateBelongsTo != .thisMonth {
            validCell.dateLabel.textColor = UIColor.lightGray
        } else {
            validCell.dateLabel.textColor = UIColor.black
        }
    }
    
    //
    // Handles pending cell's notation on the calendar (yellow dot)
    //
    func handlePendingCells(cell: DateCell, cellState: CellState) {
        self.formatter.dateFormat = "yyyy MM dd"
        let cellDateStr = formatter.string(from: cellState.date)
        let pendingDates: [String] = calendarObj.getPendingDays()
        
        if pendingDates.contains(cellDateStr) {
            cell.statusView.isHidden = false
        } else {
            cell.statusView.isHidden = true
        }
    }
    
}
