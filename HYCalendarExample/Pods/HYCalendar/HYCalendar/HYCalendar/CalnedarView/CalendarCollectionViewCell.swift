//
//  CalendarCollectionViewCell.swift
//  CalendarPOC
//
//  Created by Harry on 04/05/16.
//  Copyright © 2016 TTND. All rights reserved.
//

import UIKit

protocol CalendarCollectionViewCellDelegate : class {

    func didStartTouch(_ text:String, point:CGPoint)
    func didMoveTouch(_ point:CGPoint)
    func didEndTouch(_ point:CGPoint)
    func didCancelTouch()
}

class CalendarCollectionViewCell: UICollectionViewCell {

    var label = UILabel()
    var background = UILabel()
    var string : String?
    weak var delegate  : CalendarCollectionViewCellDelegate?

    let subViewsDefaultRatio = CGFloat(0.80)
    var width = 0
    var height = 0
    var isRTL = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    fileprivate func customInit() {
        let backgroundWidth = CGFloat(self.bounds.width * subViewsDefaultRatio)
        background.frame = CGRect(x: 0,y: (self.bounds.height - backgroundWidth)/2 ,width: backgroundWidth, height: backgroundWidth)
        background.backgroundColor = UIColor.clear
        background.center = self.center
        background.autoresizingMask = [.flexibleWidth, .flexibleTopMargin, .flexibleBottomMargin]
        self.addSubview(background)
        label.frame = CGRect(x: 0,y: 0,width: self.bounds.width, height: self.bounds.height)
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = UIColor.clear
        self.addSubview(label)
        self.backgroundColor = CollectionViewBackgroundColor
        self.label.textColor = DateDefaultColor
        label.font = DateFont

    }

    override func prepareForReuse() {
        super.prepareForReuse()
        let backgroundWidth = floor(self.bounds.width * subViewsDefaultRatio)
        background.frame = CGRect(x: 0, y: (self.bounds.height - backgroundWidth)/2 , width: backgroundWidth, height: backgroundWidth)
        background.layer.cornerRadius = 0.0
        background.layer.masksToBounds = true
        background.center = self.contentView.center
        background.backgroundColor = UIColor.clear
        self.label.textColor = DateDefaultColor
    }

    // Configure Cell UI for seleced and unselected state.
    func configureData(_ date:Date, startDate:Date?, endDate:Date?, dateRange:(startDate:Date,endDate:Date)?) {
        self.layoutIfNeeded()
        label.text = ""
        isUserInteractionEnabled = false
        background.backgroundColor = UIColor.clear
        if date == Date(timeIntervalSince1970: 0) {
            return
        } else if date.isLessThanDate(Date().addDateComponentsInDate(0)) {
            label.textColor = DisabledDateColor
            isUserInteractionEnabled = false
        } else {
            isUserInteractionEnabled = true
        }
        let day = (Calendar.current as NSCalendar).component(NSCalendar.Unit.day, from: date)
        label.text = "\(day)"
        let backgroundWidth = floor(self.bounds.width * subViewsDefaultRatio)
        if startDate != nil && endDate != nil {
            handleUIForStartDateAndEndDate(date, startDate: startDate!, endDate: endDate!)
        } else if (startDate != nil) {
            if date == startDate! {
                background.frame = CGRect(x: background.frame.origin.x,y: background.frame.origin.y, width: backgroundWidth , height: background.frame.size.height)
                background.roundCorners([.allCorners], radius:backgroundWidth/2.0)
                background.backgroundColor = SelectedDateCircleColor
                label.textColor = SelectedDateColor
            }
        } else if (startDate != nil && (date == startDate!)) {
            handleUIForSingleSelection()
        } else if (endDate != nil && (date == endDate!)) {
            handleUIForSingleSelection()
        }
        enableDatesForDateRange(date,dateRange:dateRange)
    }
    // MARK: - Handle UI for start date and end date
    private func handleUIForStartDateAndEndDate(_ date: Date, startDate: Date, endDate: Date) {
        let backgroundWidth = floor(self.bounds.width * subViewsDefaultRatio)
        let width = backgroundWidth + (self.bounds.width - backgroundWidth)/2.0
        if date.isBetweeen(date: startDate, andDate:endDate) {
            background.frame = CGRect(x: 0,y: background.frame.origin.y, width: self.contentView.bounds.size.width,height: background.frame.size.height)
            background.roundCorners([.allCorners], radius:0.0)
            background.backgroundColor = SelectedDateCircleColor
            label.textColor = SelectedDateColor
        } else if date == startDate {
            if isRTL == true {
                background.frame = CGRect(x:0,y:background.frame.origin.y, width:width,height:background.frame.size.height)
                background.roundCorners([.topRight , .bottomRight], radius:(backgroundWidth/2.0))
            } else {
                background.frame = CGRect(x: self.contentView.bounds.width - width ,y: background.frame.origin.y, width: width, height: background.frame.size.height)
                background.roundCorners([.topLeft , .bottomLeft], radius:(backgroundWidth/2.0))
            }
            background.backgroundColor = SelectedDateCircleColor
            label.textColor = SelectedDateColor
        } else if date == endDate {
            if isRTL == true {
                background.frame = CGRect(x: self.contentView.bounds.width - width,y: background.frame.origin.y,width : width, height : background.frame.size.height)
                background.roundCorners([.topLeft , .bottomLeft], radius:(backgroundWidth/2.0))
            } else {
                background.frame = CGRect(x: 0, y: background.frame.origin.y, width: width, height: background.frame.size.height)
                background.roundCorners([.topRight , .bottomRight], radius:(backgroundWidth/2.0))
            }
            background.layer.masksToBounds = false
            background.backgroundColor = SelectedDateCircleColor
            label.textColor = SelectedDateColor
        }
    }

    // MARK: - Handle UI for dingle date selection.
    private func handleUIForSingleSelection() {
        let backgroundWidth = self.bounds.width * subViewsDefaultRatio
        background.frame = CGRect(x: 0,y: background.frame.origin.y, width: backgroundWidth, height: background.frame.size.height)
        background.center = self.contentView.center
        background.roundCorners([.allCorners], radius:backgroundWidth/2.0)
        background.backgroundColor = SelectedDateCircleColor
        label.textColor = SelectedDateColor
    }

   // MARK: - Date range handling
    private func enableDatesForDateRange(_ date:Date, dateRange:(startDate:Date,endDate:Date)?) {
        if dateRange != nil {
            if !date.isBetweeen(date: dateRange!.startDate.addDateComponentsInDate(-1, monthsToAdd:0, yearsToAdd:0), andDate: dateRange!.endDate.addDateComponentsInDate(1, monthsToAdd: 0, yearsToAdd: 0)) {
                label.textColor = DisabledDateColor
                isUserInteractionEnabled = false
            }
        }
    }
}
