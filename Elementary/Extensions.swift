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
        // get each element RGB as string
        let redStr = hex.substring(to: 2)
        let greenStr = hex.substring(with: 2..<4)
        let blueStr = hex.substring(with: 4..<6)
        
        // convert substring hex values to int
        let r = Int(redStr, radix: 16)!
        let g = Int(greenStr, radix: 16)!
        let b = Int(blueStr, radix: 16)!
        
        // make colour
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
    }
}

// Get round weird requirement for 'index' to be provided rather than just an int
extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(to: Int) -> String {
        let finalExclusive = index(from: to)
        return substring(to: finalExclusive)
    }
    
    func substring(with range: Range<Int>) -> String {
        let initialInclusive = index(from: range.lowerBound)
        let finalExclusive = index(from: range.upperBound)
        return substring(with: initialInclusive..<finalExclusive)
    }

}

extension CGFloat {
    // Cant be bothered with radians
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 180
    }
}

extension CGPoint {
    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
}

