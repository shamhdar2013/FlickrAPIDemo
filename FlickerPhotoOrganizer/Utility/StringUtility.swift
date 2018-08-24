//
//  StringUtility.swift
//  FlickerPhotoOrganizer
//
//  Created by RADHIKA SHARMA on 8/23/18.
//  Copyright © 2018 RADHIKA SHARMA. All rights reserved.
//

import UIKit

class StringUtility {
    class func attributedString(text: String, fontName: String = "Verdana-BoldItalic", size: CGFloat) -> NSAttributedString {
        var stringAttributes = [NSAttributedStringKey : Any]()
        stringAttributes[NSAttributedStringKey.foregroundColor] = UIColor.purple
        
        if let font = UIFont(name: fontName, size: size) {
            stringAttributes[ NSAttributedStringKey.font] = font
        }
        return NSAttributedString(string: text, attributes: stringAttributes)
    }

}
