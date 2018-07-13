//
//  StringTools.swift
//  HMFlickr
//
//  Created by Hayden Malcomson on 2018-07-12.
//  Copyright © 2018 Hayden Malcomson. All rights reserved.
//

import Foundation
import UIKit

class StringTools {
    static func getWidthBoundsForStringOfSize(string: String, fontSize: CGFloat, heightDim: CGFloat, horizontalPadding: CGFloat) -> CGSize {
        let attributedString = NSAttributedString(string: string, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: fontSize, weight: .regular)])
        let boundingRect = attributedString.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: heightDim), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        return CGSize(width: boundingRect.width + horizontalPadding, height: heightDim)
    }
}


