//
//  ViewController.swift
//  PootCal
//
//  Created by User on 1/26/18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit
import JTAppleCalendar

class Cal_VC: UIViewController {
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!

    let formatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupCalendar()
    }
}

extension Cal_VC: JTAppleCalendarViewDataSource {
    
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

extension Cal_VC: JTAppleCalendarViewDelegate {
    //  *   Displays the cell    *
    
    //Protocols for JTAppleCalendar
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "DateCell", for: indexPath) as! DateCell
        
        cell.dateLabel.text = cellState.text
        setupCellNotations(cell: cell, cellState: cellState)
        handleCellTextColor(cell: cell, cellState: cellState)
        
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
    
    //Select correct month when scrolling
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupMonthAndYear(from: visibleDates)
    }
}

extension Cal_VC {
    
    //  *   Setup Functions *
    
    func setupCalendar() {
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        calendarView.allowsMultipleSelection = true
        
        //set up labels
        calendarView.visibleDates { (visibleDates) in
            self.setupMonthAndYear(from: visibleDates)
        }
    }
    func setupMonthAndYear(from visibleDates: DateSegmentInfo){
        let date = visibleDates.monthDates.first!.date
        //format year and month
        self.formatter.dateFormat = "yyyy"
        self.yearLabel.text = self.formatter.string(from: date)
        
        self.formatter.dateFormat = "MMMM"
        self.monthLabel.text = self.formatter.string(from: date)
    }
    
    func setupCellNotations(cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? DateCell else {  return  }
        if cellState.isSelected {
            validCell.selectedView.isHidden = false
        } else {
            validCell.selectedView.isHidden = true
        }
    }
    
    func handleCellTextColor(cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? DateCell else {  return  }
        if cellState.dateBelongsTo != .thisMonth {
            validCell.dateLabel.textColor = UIColor.lightGray
        } else {
            validCell.dateLabel.textColor = UIColor.black
        }
    }
}



