//
//  Extensions.swift
//  Elementary
//
//  Created by Cooper Richard on 5/1/18.
//  Copyright © 2018 Rick Cooper. All rights reserved.
//

import Foundation
import UIKit


extension UIColor {
    // adapted https://gist.github.com/arshad/de147c42d7b3063ef7bc
    convenience init(_ hex: String) {
        let redStr = hex.substring(to: 2)
        let greenStr = hex.substring(with: 2..<4)
        let blueStr = hex.substring(with: 4..<6)
        
        let r = Int(redStr, radix: 16)!
        let g = Int(greenStr, radix: 16)!
        let b = Int(blueStr, radix: 16)!
        
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
    }
}

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }

}
