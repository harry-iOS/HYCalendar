//
//  CalendarView.swift
//  CalendarPOC
//
//  Created by Harry on 03/05/16.
//  Copyright © 2016 TTND. All rights reserved.
//

import UIKit

public protocol CalendarViewDelegate : class {
    func didSelectDate(_ startDate:Date?, endDate:Date?)
}

public class CalendarView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {

    fileprivate var label = UILabel()
    fileprivate var collectionView : UICollectionView!
    fileprivate var dataSourceArray = [AnyObject]()
    fileprivate var previousSelectedStartDate: Date?
    fileprivate var previousSelectedEndDate: Date?
    fileprivate var calendarHeaderHeight : CGFloat?
    fileprivate var collectionViewOriginalWidth: CGFloat?

    public var isRTL = false
    public var canCheckSingleDate = false
    public var calendarUIOptions:[CalenderUIOptions]? {
        didSet {
            if let options = calendarUIOptions {
                for option in options {
                    switch (option) {
                    case let .collectionViewBackgroundColor(value):
                        CollectionViewBackgroundColor = value
                    case let .selectedDateCircleColor(value):
                        SelectedDateCircleColor = value
                    case let .selectedDateColor(value):
                        SelectedDateColor = value
                    case let .headerBackgroundColor(value):
                        HeaderBackgroundColor = value
                    case let .headerCellTextColor(value):
                        HeaderCellTextColor = value
                    case let .disabledDateColor(value):
                        DisabledDateColor = value
                    case let .dateDefaultColor(value):
                        DateDefaultColor = value
                    case let .headerViewTitleColor(value):
                        HeaderViewTitleColor = value
                    case let .headerCellTextFont(value):
                        HeaderCellTextFont = value
                    case let .dateFont(value):
                        DateFont = value
                    case let .headerViewTitleFont(value):
                        HeaderViewTitleFont = value
                    }
                }
            }
        }
    }

    public var dateRange : (startDate:Date,endDate:Date)? // set date range if you want to enable the range within dates.

    public weak var delegateObj : CalendarViewDelegate?

    override init (frame : CGRect) {
        super.init(frame : frame)
        commonInit()
    }

    convenience init () {
        self.init(frame:CGRect.zero)
        commonInit()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        calendarHeaderHeight = self.bounds.width * (60 / 320)
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.frame = CGRect(x: 0,y: 0,width: collectionViewOriginalWidth!, height: self.bounds.height)
        collectionView.center = CGPoint(x: self.center.x, y: collectionView.center.y)
        if isRTL == false {
            collectionView.semanticContentAttribute = UISemanticContentAttribute.forceLeftToRight
        } else {
            collectionView.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
        }
        let layout = getCollectionViewLayout()
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.reloadData()
    }

    // MARK: - Common Init
    fileprivate func commonInit() {
        calendarHeaderHeight = self.bounds.width * (60 / 320)
        let layout = getCollectionViewLayout()
        collectionView = UICollectionView(frame:self.bounds,collectionViewLayout: layout)
        collectionView.backgroundColor = CollectionViewBackgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(CalendarHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier:"sectionHeader")
        self.addSubview(collectionView)
        collectionView.reloadData()
    }

   // MARK: - Collection view layout
    fileprivate func getCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        collectionViewOriginalWidth = ceil(width/7) * 7
        layout.itemSize = CGSize(width: collectionViewOriginalWidth!/7, height: collectionViewOriginalWidth!/7)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.headerReferenceSize = CGSize(width: width, height: calendarHeaderHeight!)
        layout.sectionHeadersPinToVisibleBounds = true
        return layout
    }

  // MARK: - Render data
   public func renderData(_ fromMonth:Int, fromYear:Int, toMonth:Int, toYear:Int, startDate:Date?, endDate:Date?) {
        previousSelectedStartDate = startDate
        previousSelectedEndDate = endDate
        CalenderDataSource().getDataSourceForCalendar(fromMonth, fromYear: fromYear, toMonth: toMonth, toYear: toYear) { (array) in
            self.dataSourceArray = array
            self.collectionView.reloadData()
        }
    }

 // MARK: - Scroll to selcted date
    public func scrollToSelectedDates(_ date:Date?) { // scroll to date
        if date != nil {
            let month = (Calendar.current as NSCalendar).component(NSCalendar.Unit.month, from: date!)
            let year = (Calendar.current as NSCalendar).component(NSCalendar.Unit.year, from: date!)

            let currentMonth = (Calendar.current as NSCalendar).component(NSCalendar.Unit.month, from:Date())
            let currentYear = (Calendar.current as NSCalendar).component(NSCalendar.Unit.year, from: Date())

            let section = (year - currentYear) * 12 + (month - currentMonth)

            let lastIndex = dataSourceArray[section].count - 1
            self.collectionView.scrollToItem(at: IndexPath.init(item: lastIndex, section:section), at: UICollectionViewScrollPosition.bottom, animated: false)
            self.collectionView.reloadData()
        }

    }

// MARK: - Collection view datasource methods
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSourceArray.count
    }

    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {

        case UICollectionElementKindSectionHeader:
            let headerView =
                collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "sectionHeader", for: indexPath) as? CalendarHeaderView
            headerView?.isRTL = isRTL
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM"
            let date = (dataSourceArray[(indexPath as NSIndexPath).section] as? [AnyObject])?.last as? Date
            let month = dateFormatter.string(from: date!)
            dateFormatter.dateFormat = "yyyy"
            let year = dateFormatter.string(from: date!)
            let title = month + " " + year
            headerView?.configureHeader(title.uppercased())
            headerView?.backgroundColor = HeaderBackgroundColor
            return headerView!
        default:
            return UICollectionReusableView()
        }
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let array = dataSourceArray[section]
        return array.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CalendarCollectionViewCell
        cell?.isRTL = isRTL
        let date = (dataSourceArray[indexPath.section] as? [AnyObject])?[(indexPath as NSIndexPath).item] as? Date
        cell?.configureData(date!, startDate: previousSelectedStartDate, endDate:previousSelectedEndDate, dateRange:dateRange)
        return cell!
    }
    // MARK: - Collection view delegate methods
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let date = (dataSourceArray[(indexPath as NSIndexPath).section] as? [AnyObject])?[(indexPath as NSIndexPath).item] as? Date
        handleDateSelection(date!)
    }
    // MARK: - Date selection handling
   fileprivate func handleDateSelection(_ selectedDate:Date) {

        if canCheckSingleDate {
            previousSelectedStartDate = selectedDate
            previousSelectedEndDate = nil
        } else {
            if previousSelectedStartDate != nil && previousSelectedEndDate != nil {
                previousSelectedStartDate = selectedDate
                previousSelectedEndDate = nil
            } else if (previousSelectedStartDate != nil && previousSelectedEndDate == nil) {
                if selectedDate.isGreaterThanDate(previousSelectedStartDate!) {
                    previousSelectedEndDate = selectedDate
                } else {
                    previousSelectedStartDate = selectedDate
                    previousSelectedEndDate = nil
                }
            }
        }
        delegateObj?.didSelectDate(previousSelectedStartDate, endDate: previousSelectedEndDate)
        collectionView.reloadData()
    }

    // MARK: - Scroll view delegate methods
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        if decelerate == false {
            collectionView.reloadData()
        }
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        collectionView.reloadData()
    }

     public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

        collectionView.reloadData()
    }
}
