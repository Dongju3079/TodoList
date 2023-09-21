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

struct MyProfilePhoto {
    static var cellColumns: CGFloat = 3
    static var spacingWidth: CGFloat = 2
    static var photoList: [String] = []
    
    static var photoList1: [String] = []
    
    static var photoList2: [String] = []
}
