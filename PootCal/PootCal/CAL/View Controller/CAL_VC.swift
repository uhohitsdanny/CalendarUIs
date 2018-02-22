//
//  ViewController.swift
//  PootCal
//
//  Created by User on 1/26/18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit
import JTAppleCalendar


protocol CAL_VC_PAR {
    var sts:CAL_DISPLAY { get }
}

class CAL_VC: UIViewController, CAL_VC_PAR {
    
    var cal_sts:CAL_DISPLAY = .selecting
    var sts: CAL_DISPLAY {  return self.cal_sts }
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    var calendarObj = CAL_MC(CAL_DISPLAY.selecting)
    let formatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupCalendar()
    }
}

extension CAL_VC: JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let start = formatter.date(from: "2018 01 01")!
        let end = formatter.date(from: "2018 12 31")!
        
        let parameters = ConfigurationParameters(startDate: start, endDate: end)
        return parameters
    }
}

extension CAL_VC: JTAppleCalendarViewDelegate {
    //  *   Displays the cell    *
    
    //Protocols for JTAppleCalendar
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "DateCell", for: indexPath) as! DateCell
        
        cell.dateLabel.text = cellState.text
        setupCellNotations(cell: cell, cellState: cellState)
        handleCellTextColor(cell: cell, cellState: cellState)
        handleCellCurrentDate(cell: cell, cellState: cellState)
        
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
    }
    
    //Cell Selection Func
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        setupCellNotations(cell: cell, cellState: cellState)
    }
    
    //Cell Deselect Func
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        setupCellNotations(cell: cell, cellState: cellState)
    }
}

extension CAL_VC {
    
    //  *   Setup Functions *
    func setupCalendar() {
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        calendarView.allowsMultipleSelection = true
        calendarView.scrollToDate(Date())
        
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
            self.addChildViewController(vc)
            vc.view.frame = self.view.frame
            self.view.addSubview(vc.view)
            vc.didMove(toParentViewController: self)
        }
        
    }
}

//
// *    Handlers    *
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



