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
extension CAL_MV {
    
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
    func handleStsOfCells(cell: DateCell, cellState: CellState) {
        self.formatter.dateFormat = "yyyy MM dd"
        let cellDateStr = formatter.string(from: cellState.date)
        let pendingDates: [String] = calendarObj.getPendingDays()
        let unavailDates: [String] = calendarObj.getUnavailableDays()
        
        if pendingDates.contains(cellDateStr) {
            cell.statusView.isHidden = false
            cell.statusView.backgroundColor = UIColor.NotificationColors.pending
        }
        else if unavailDates.contains(cellDateStr){
            cell.statusView.isHidden = false
            cell.statusView.backgroundColor = UIColor.NotificationColors.unavailable
        } else {
            cell.statusView.isHidden = true
        }
    }
    
    func handleSegue(sts: Status, date: String) -> Void {
        //
        // Segue to DateInfo ViewController as a popup view
        //
        let sb = UIStoryboard(name: "CAL", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DateInfo") as! DateInfo_MV
        
        // Get the status of the date and the date itself
        vc.dSts = sts
        vc.cdate = date
        
        self.addChildViewController(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
    }
    
}
