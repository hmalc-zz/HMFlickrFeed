//
//  FoundationExtensions.swift
//  HMFlickr
//
//  Created by Hayden Malcomson on 2018-07-12.
//  Copyright © 2018 Hayden Malcomson. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func getWidthBoundsForStringOfSize(fontSize: CGFloat, heightDim: CGFloat, horizontalPadding: CGFloat) -> CGSize {
        let attributedString = NSAttributedString(string: self, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: fontSize, weight: .regular)])
        let boundingRect = attributedString.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: heightDim), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        return CGSize(width: boundingRect.width + horizontalPadding, height: heightDim)
    }
}

extension Date {
    
    func formatDateAs(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func timeStringRelativeToNow() -> String {
        let calendar = Calendar.current
        let unitFlags: Set<Calendar.Component> = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
        
        let suffixString = " ago"
        let prefixString = "Last "

        var components: DateComponents = calendar.dateComponents(unitFlags, from: self, to: Date())
        
        if components.year! >= 2 {
            return "\(components.year!) years" + suffixString
        }
        
        if components.year! >= 1 {
            return prefixString + "year"
        }
        
        if components.month! >= 2 {
            return "\(components.month!) months" + suffixString
        }
        
        if components.month! >= 1 {
            return prefixString + "month"
        }
        
        if components.weekOfYear! >= 2 {
            return "\(components.weekOfYear!) weeks" + suffixString
        }
        
        if components.weekOfYear! >= 1 {
            return prefixString + "week"
        }
        
        if components.day! >= 2 {
            return "\(components.day!) days" + suffixString
        }
        
        if components.day! >= 1 {
            return "Yesterday"
        }
        
        if components.hour! >= 2 {
            return "\(components.hour!)hrs" + suffixString
        }
        
        if components.hour! >= 1 {
            return "An hour ago"
        }
        
        if components.minute! >= 2 {
            return "\(components.minute!) mins" + suffixString
        }
        
        if components.minute! >= 1 {
            return "A min ago"
        }
        
        if components.second! >= 3 {
            return "\(components.second!) secs" + suffixString
        }
        return "Just now"
    }
}

