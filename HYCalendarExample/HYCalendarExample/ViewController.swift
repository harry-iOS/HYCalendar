//
//  ViewController.swift
//  HYCalendarExample
//
//  Created by Harry on 10/09/17.
//  Copyright © 2017 Harry. All rights reserved.
//

import UIKit
import HYCalendar

class ViewController: UIViewController, CalendarViewDelegate {
    
    let calendar = CalendarView()
    fileprivate var start : Date?
    fileprivate var end : Date?
    var dateRange : (startDate:Date,endDate:Date)?
    var canCheckSingleDate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.calendarUIOptions = [.selectedDateCircleColor(UIColor.red)]
        view.addSubview(calendar) // add subview calendar
        configureView()
        let startMonth = Date.init().getMonthFromDateForCalendar()
        let startYear = Date.init().getYearFromDateForCalendar()
        let lastMonth = Date.init().addDateComponentsInDate(0, monthsToAdd:40).getMonthFromDateForCalendar()
        let lastYear = Date.init().addDateComponentsInDate(0, monthsToAdd:40).getYearFromDateForCalendar()
        renderData(startMonth, fromYear: startYear, toMonth: lastMonth, toYear: lastYear, startDate: nil, endDate: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Configure Calender View
    fileprivate func configureView() {
        calendar.frame = CGRect.init(x: 0, y: 20, width: view.bounds.width, height: view.bounds.height - 20)
        calendar.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        calendar.delegateObj = self // delegate
        calendar.isRTL = false // RTL and LTR support
    }
    
    // MARK: - Render data on calendar and configure check in and check out date
    func renderData(_ fromMonth:Int, fromYear:Int, toMonth:Int, toYear:Int, startDate:Date?, endDate:Date?) {
        start = startDate
        end = endDate
        
        //Configure default dates if user has not selected check in and check out dates
        if start == nil && end == nil {
            start = Date().addDateComponentsInDate(1)
            if canCheckSingleDate == false {
                end = Date().addDateComponentsInDate(2)
            }
        }
        
        //Validation and change in check in and check out date if date range is not nil
        if dateRange != nil {
            if start != nil && start!.isLessThanDate(dateRange!.startDate) {
                end = dateRange?.startDate
            }
            
            if end != nil {
                if end!.isGreaterThanDate(dateRange!.endDate) {
                    end = dateRange!.endDate
                } else if endDate!.isLessThanDate(dateRange!.startDate) || (endDate! == (dateRange!.startDate)) {
                    end = start!.addDateComponentsInDate(1)
                }
            }
        }
        
        //Handle date enabled and disbaled state based on date range
        calendar.dateRange = dateRange
        calendar.canCheckSingleDate = canCheckSingleDate
        calendar.renderData(fromMonth, fromYear: fromYear, toMonth:toMonth , toYear: toYear, startDate: start, endDate:end)
        
        //Scroll calendar to show the selected dates
        var dateToScroll = start
        if end != nil {
            dateToScroll = end
        }
        let dispatchTime: DispatchTime = DispatchTime.now() + Double(Int64(0.2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            self.calendar.scrollToSelectedDates(dateToScroll)
        })
        
    }
    
    // MARK: - Calnedar view delegate method
    func didSelectDate(_ startDate: Date?, endDate: Date?) {
        start = startDate
        end = endDate
    }
    
}
