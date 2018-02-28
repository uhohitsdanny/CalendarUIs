//
//  SetupFunctions.swift
//  PootCal
//
//  Created by Danny Navarro on 2/27/18.
//  Copyright © 2018 User. All rights reserved.
//

import JTAppleCalendar

extension CAL_VC {
    
    //  *   Setup Functions *
    func setupCalendar() {
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        calendarView.allowsMultipleSelection = true
        calendarView.scrollToDate(Date(), animateScroll: false)
        
        //Set up labels
        calendarView.visibleDates { (visibleDates) in
            self.setupMonthAndYear(from: visibleDates)
        }
    }
    
    // Sets up the Month and Year label according to current time and locale
    func setupMonthAndYear(from visibleDates: DateSegmentInfo){
        let date = visibleDates.monthDates.first!.date
        //format year and month
        self.formatter.dateFormat = "yyyy"
        self.yearLabel.text = self.formatter.string(from: date)
        
        self.formatter.dateFormat = "MMMM"
        self.monthLabel.text = self.formatter.string(from: date)
    }
    
    // Handle the type of cell notations used depending on whether
    // the Calendar module is being called for Selecting or Displaying statuses
    
    func setupCellNotations(cell: JTAppleCell?, cellState: CellState) {
        if cal_sts == .selecting {
            setupForSelecting(cell: cell, cellState: cellState)
        }
        else if cal_sts == .display_sts {
            setupForDisplay(cell: cell, cellState: cellState)
        }
    }
    
    func setupForSelecting(cell: JTAppleCell?, cellState: CellState){
        guard let validCell = cell as? DateCell else {  return  }
        self.formatter.dateFormat = "yyyy MM dd"
        
        let todaysDateStr = formatter.string(from: Date())
        let cellDateStr = formatter.string(from: cellState.date)
        
        // only allow selection from current date and after
        // and dates that are not in and out dates
        if cellState.isSelected && cellDateStr >= todaysDateStr && cellState.dateBelongsTo == .thisMonth
        {
            validCell.selectedView.isHidden = false
            self.calendarObj.saveSelectedDay(cellDateStr)
        }
        else if !cellState.isSelected && !calendarObj.getSelectedDays().isEmpty && cellState.dateBelongsTo == .thisMonth
        {
            self.calendarObj.removeDeselectedDay(cellDateStr)
            validCell.selectedView.isHidden = true
        }
        else {
            validCell.selectedView.isHidden = true
        }
    }
    
    //
    //  Sets up the Calendar for when the user is checking for status on dates
    //
    func setupForDisplay(cell: JTAppleCell?, cellState: CellState) {
        
        guard let validCell = cell as? DateCell else { return }
        handlePendingCells(cell: validCell, cellState: cellState)
        self.formatter.dateFormat = "yyyy MM dd"
        let cellDateStr = formatter.string(from: cellState.date)
        let pendingDates: [String] = calendarObj.getPendingDays()
        
        if validCell.isSelected && pendingDates.contains(cellDateStr) && cellState.dateBelongsTo == .thisMonth
        {
            //
            // Segue to DateInfo ViewController as a popup view
            //
            let sb = UIStoryboard(name: "CAL_VC", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "DateInfo") as! DateInfo_VC
            vc.dSts = .pending
            vc.cdate = cellDateStr
            
            self.addChildViewController(vc)
            vc.view.frame = self.view.frame
            self.view.addSubview(vc.view)
            vc.didMove(toParentViewController: self)
        }
        
    }
}
