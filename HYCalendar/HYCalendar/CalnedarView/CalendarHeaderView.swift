//
//  CalendarHeaderView.swift
//  CalendarPOC
//
//  Created by Harry on 14/11/16.
//  Copyright © 2016 TTND. All rights reserved.
//

import UIKit

class CalendarHeaderView: UICollectionReusableView, UICollectionViewDataSource {

    fileprivate var label : UILabel?
    fileprivate var collectionView : UICollectionView!
    fileprivate var dataSourceArray = [String]()
    fileprivate var monthLabelHeight = CGFloat(0.0)
    var isRTL = false

    override init (frame : CGRect) {
        super.init(frame : frame)
        commonInit()
    }

    convenience init () {
        self.init(frame:CGRect.zero)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        monthLabelHeight = self.bounds.height/2
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.frame = CGRect(x: 0,y: monthLabelHeight,width: self.frame.width,height: monthLabelHeight)
        collectionView.backgroundColor = CollectionViewBackgroundColor
        let layout = getCollectionViewLayout()
        if isRTL == true {
            collectionView.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
        } else {
            collectionView.semanticContentAttribute = UISemanticContentAttribute.forceLeftToRight
        }
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.reloadData()
    }

    // MARK: - Common Init
    fileprivate func commonInit() {
        monthLabelHeight = self.bounds.height/2
        dataSourceArray = ["Su","Mo","Tu","We","Th","Fr","Sa"]
        label = UILabel(frame:CGRect(x: 0,y: 0, width: self.bounds.width,height: monthLabelHeight))
        label?.textAlignment = .center
        label?.textColor = HeaderViewTitleColor
        label?.font = HeaderViewTitleFont
        let layout = getCollectionViewLayout()
        collectionView = UICollectionView(frame:CGRect(x: 0,y: monthLabelHeight,width: self.frame.width,height: monthLabelHeight),collectionViewLayout: layout)
        collectionView.dataSource = self
        self.addSubview(label!)
        self.addSubview(collectionView)
        collectionView.register(CalendarHeaderCell.self, forCellWithReuseIdentifier: "headerCell")
        collectionView.backgroundColor = UIColor.clear
        collectionView.reloadData()
    }

   // MARK: - Collection view layout
    fileprivate func getCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let itemWidth = self.frame.width/7
        layout.itemSize = CGSize(width: itemWidth,height: monthLabelHeight)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        return layout
    }

  // MARK: - Collection view datasource methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourceArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "headerCell", for: indexPath) as? CalendarHeaderCell
        cell?.configureTitle(dataSourceArray[(indexPath as NSIndexPath).item])
        return cell!
    }

 // MARK: - Configure Header
    func configureHeader(_ monthName:String) {
        label?.text = monthName
    }

}
