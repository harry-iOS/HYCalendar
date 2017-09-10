//
//  CalendarConstants.swift
//  HYCalendar
//
//  Created by Harry on 31/03/17.
//  Copyright © 2017 Harry. All rights reserved.
//

import UIKit

public enum CalenderUIOptions {
    case collectionViewBackgroundColor(UIColor)
    case selectedDateCircleColor(UIColor)
    case selectedDateColor(UIColor)
    case headerBackgroundColor(UIColor)
    case headerCellTextColor(UIColor)
    case disabledDateColor(UIColor)
    case dateDefaultColor(UIColor)
    case headerViewTitleColor(UIColor)
    case headerCellTextFont(UIFont)
    case dateFont(UIFont)
    case headerViewTitleFont(UIFont)
}

// MARK: - Manage Calendar colors

var CollectionViewBackgroundColor = Utils.hexStringToUIColorWithAlphaComponent("#f7f7f7", alphaComponenet: 1.0)
var SelectedDateCircleColor = Utils.hexStringToUIColorWithAlphaComponent("#5a5ee3", alphaComponenet: 1)
var SelectedDateColor = UIColor.white
var HeaderBackgroundColor = UIColor.white
var HeaderCellTextColor = Utils.hexStringToUIColorWithAlphaComponent("#2e343b", alphaComponenet: 1.0)
var DisabledDateColor = Utils.hexStringToUIColorWithAlphaComponent("#8d99a6", alphaComponenet: 0.3)
var DateDefaultColor = Utils.hexStringToUIColorWithAlphaComponent("#888888", alphaComponenet: 1.0)
var HeaderViewTitleColor = Utils.hexStringToUIColorWithAlphaComponent("#2e343b", alphaComponenet: 1.0)

// MARK: - Manage Calendar Fonts

var HeaderCellTextFont = UIFont.systemFont(ofSize: 13)
var DateFont = UIFont.systemFont(ofSize: 13)
var HeaderViewTitleFont = UIFont.systemFont(ofSize: 15)
