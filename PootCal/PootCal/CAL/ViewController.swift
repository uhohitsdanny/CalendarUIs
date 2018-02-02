//
//  ViewController.swift
//  PootCal
//
//  Created by User on 1/26/18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit
import JTAppleCalendar

class ViewController: UIViewController {
    @IBOutlet weak var calendarView: JTAppleCalendarView!

    let formatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupCalendar()
    }

    func setupCalendar() {
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
    }
    
    func setupCellNotations(cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? DateCell else {  return  }
        if cellState.isSelected {
            validCell.selectedView.isHidden = false
        } else {
            validCell.selectedView.isHidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: JTAppleCalendarViewDataSource {
    
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

extension ViewController: JTAppleCalendarViewDelegate {
    //Display the cell
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "DateCell", for: indexPath) as! DateCell
        
        cell.dateLabel.text = cellState.text
        setupCellNotations(cell: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "DateCell", for: indexPath) as! DateCell
        
        cell.dateLabel.text = cellState.text
        setupCellNotations(cell: cell, cellState: cellState)
        
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


