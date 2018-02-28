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

protocol CAL_VC_API {
    func mSetup()
}

//
// CAL_VC View Controller controls the type of Calendar mode to display
// Modes: Selecting | Displaying Status
//
// CAL_VC View Controller can also invoke the DateInfo_VC View Controller
//
class CAL_MV: UIViewController, CAL_VC_PAR {
    
    var cal_sts:CAL_DISPLAY = .selecting
    var sts: CAL_DISPLAY {  return self.cal_sts }
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    var calendarObj = CAL_MC(CAL_DISPLAY.selecting)
    let formatter = DateFormatter()
    
    override func viewWillAppear(_ animated: Bool) {
        mSetup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // setupCalendar()
    }
}

extension CAL_MV: JTAppleCalendarViewDataSource {
    
    // Date Source protocols for JTAppleCalendar
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

extension CAL_MV: JTAppleCalendarViewDelegate {
    
    //  *   Displays the cell in the calendar   *
    // Protocols for JTAppleCalendarView Delegate
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
    
    //Scrolling Func
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        //format year and month
        self.formatter.dateFormat = "yyyy"
        self.yearLabel.text = self.formatter.string(from: date)
        
        self.formatter.dateFormat = "MMMM"
        self.monthLabel.text = self.formatter.string(from: date)
    }
}

extension CAL_MV: CAL_VC_API {
    func mSetup() {
        setupCalendar()
    }
}




