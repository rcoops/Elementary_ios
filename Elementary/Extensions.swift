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
    
    static func createTranslucent(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: 0.75)
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
    func toDegrees() -> CGFloat {
        return self * 180 / CGFloat(Double.pi)
    }
}

extension CGPoint {
    
    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    /*
     calc displacement around an axis
     https://www.youtube.com/watch?v=LhL59Ipehms
     https://math.stackexchange.com/questions/156833/how-to-find-a-point-after-rotation
     positive angle (counter-clockwise)
     x' = y*sin(a) + x*cos(a)
     y' = y*cos(a) - x*sin(a)
     negative angle (clockwise)
     x' = x*cos(a) - y*sin(a)
     y' = y*cos(a) + x*sin(a)
     */
    func toRotatedPosition(rotationInRadians: CGFloat) -> CGPoint {
        if rotationInRadians >= 0 {
            let spritePositionX = self.y * sin(rotationInRadians) + self.x * cos(rotationInRadians)
            let spritePositionY = self.y * cos(rotationInRadians) - self.x * sin(rotationInRadians)
            return CGPoint(x: spritePositionX, y: spritePositionY)
        } else {
            let spritePositionX = self.x * cos(rotationInRadians) - self.y * sin(rotationInRadians)
            let spritePositionY = self.y * cos(rotationInRadians) + self.x * sin(rotationInRadians)
            return CGPoint(x: spritePositionX, y: spritePositionY)
        }
    }
    
}

extension UIViewController {
    func alertWithTitle(title: String!, message: String, ViewController: UIViewController, action: ((UIAlertAction) -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: action))
        ViewController.present(alert, animated: true, completion:nil)
    }
    
    func setBackground(_ image: UIImage) {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = image
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
}
