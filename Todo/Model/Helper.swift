//
//  Helper.swift
//  Todo
//
//  Created by Macbook on 2023/08/26.
//

import UIKit

struct MyColor {
    static let backColor = UIColor(red: 1.00, green: 0.95, blue: 0.69, alpha: 1.00)
}

struct MyCategorie {
    static var cellColumns: CGFloat = 3
    static var spacingWidth: CGFloat = 3
    
    static var cellHeight: CGFloat = 44
    static var cellViewHighHeight: CGFloat = (cellHeight + spacingWidth) * cellColumns - spacingWidth
    static var cellViewMiddelHeight: CGFloat = (cellHeight + spacingWidth) * (cellColumns-1) - spacingWidth
    static var cellViewLowHeight: CGFloat = cellHeight
}
