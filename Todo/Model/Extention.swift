//
//  Extention.swift
//  Todo
//
//  Created by Macbook on 2023/08/26.
//

import UIKit

protocol MemoDelegate: AnyObject {
    func tableViewUpdate(section: Int)
}

// UITextView를 커스텀해서 커서의 크기를 조정
class CustomTextView: UITextView {
    override func caretRect(for position: UITextPosition) -> CGRect {
        var superRect = super.caretRect(for: position)
        superRect.size.height = 30 // 원하는 높이로 조정
        return superRect
    }
}
