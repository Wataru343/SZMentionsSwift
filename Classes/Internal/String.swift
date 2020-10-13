//
//  String.swift
//  SZMentionsSwift
//
//  Created by Steve Zweier on 2/1/16.
//  Copyright © 2016 Steven Zweier. All rights reserved.
//

import UIKit

internal extension String {
    func range(of strings: [String], options: NSString.CompareOptions, range: NSRange? = nil) -> (range: NSRange, foundString: String) {
        let nsself = (self as NSString)
        var foundRange = NSRange(location: NSNotFound, length: 0)
        var string = ""
        
        strings.forEach {
            var tempRange = NSRange(location: NSNotFound, length: 0)
            if let range = range {
                tempRange = nsself.range(of: $0, options: options, range: range)
            } else {
                tempRange = nsself.range(of: $0, options: options)
            }
            if foundRange.location + foundRange.length < tempRange.location + tempRange.length {
                foundRange = tempRange
                string = $0
            }
        }

        return (foundRange, string)
    }

    func isMentionEnabledAt(_ location: Int) -> (Bool, String) {
        guard location != 0 else { return (true, "") }

        let start = utf16.index(startIndex, offsetBy: location - 1)
        let end = utf16.index(start, offsetBy: 1)
        let textBeforeTrigger = String(utf16[start ..< end]) ?? ""

        return (textBeforeTrigger == " " || textBeforeTrigger == "\n", textBeforeTrigger)
    }
}
