//
//  CalendarHeaderCell.swift
//  CalendarPOC
//
//  Created by Harry on 14/11/16.
//  Copyright © 2016 TTND. All rights reserved.
//

import UIKit

class CalendarHeaderCell: UICollectionViewCell {

    var label : UILabel!
    var string : String?

    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }

    private func customInit() {
        label = UILabel(frame:self.bounds)
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.center = self.contentView.center
        label.textAlignment = NSTextAlignment.center
        label.textColor = HeaderCellTextColor
        label.font = HeaderCellTextFont
        self.contentView.addSubview(label)
        self.backgroundColor = UIColor.clear
        isUserInteractionEnabled = false
    }

    override func prepareForReuse() {
        label.text = ""
    }

    func configureTitle(_ title:String) {
        label.text = title
    }

}
