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
        handlePendingCells(cell: cell, cellState: cellState)
        
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
    func setupMonthAndYear(from visibleDates: DateSegmentInfo){
        let date = visibleDates.monthDates.first!.date
        //format year and month
        self.formatter.dateFormat = "yyyy"
        self.yearLabel.text = self.formatter.string(from: date)
        
        self.formatter.dateFormat = "MMMM"
        self.monthLabel.text = self.formatter.string(from: date)
    }
    
    func setupCellNotations(cell: JTAppleCell?, cellState: CellState) {
        if cal_sts == .selecting {
            setupForSelecting(cell: cell, cellState: cellState)
        }
        else if cal_sts == .display_sts {
            setupForDisplay(cell: cell, cellState: cellState)
        }
    }
    
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
    
    func handleCellTextColor(cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? DateCell else {  return  }
        if cellState.dateBelongsTo != .thisMonth {
            validCell.dateLabel.textColor = UIColor.lightGray
        } else {
            validCell.dateLabel.textColor = UIColor.black
        }
    }
    
    func handlePendingCells(cell: JTAppleCell?, cellState: CellState){
        //guard let validCell = cell as? DateCell else {  return  }
        
    }
}

extension CAL_VC {
    func setupForSelecting(cell: JTAppleCell?, cellState: CellState){
        guard let validCell = cell as? DateCell else {  return  }
        self.formatter.dateFormat = "yyyy MM dd"
        
        let todaysDateStr = formatter.string(from: Date())
        let cellDateStr = formatter.string(from: cellState.date)
        
        // only allow selection from current date and after
        if cellState.isSelected && cellDateStr >= todaysDateStr {
            
            validCell.selectedView.isHidden = false
            self.calendarObj.saveSelectedDay(cellDateStr)
            
        }
        else if !cellState.isSelected && !calendarObj.getSelectedDays().isEmpty {
            self.calendarObj.removeDeselectedDay(cellDateStr)
            validCell.selectedView.isHidden = true
        }
        else {
            
            validCell.selectedView.isHidden = true
            
        }
    }
    
    func setupForDisplay(cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? DateCell else { return }
        self.formatter.dateFormat = "yyyy MM dd"
        let cellDateStr = formatter.string(from: cellState.date)
        
        let pendingDates: [String] = calendarObj.getPendingDays()
        if pendingDates.contains(cellDateStr) {
            validCell.statusView.isHidden = false
        } else {
            validCell.statusView.isHidden = true
        }
    }
}



