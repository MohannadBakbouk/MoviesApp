//
//  UIColor.swift
//  MoviesApp
//
//  Created by Mohannad on 29/01/2024.
//

import UIKit
extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
             var int = UInt64()
             Scanner(string: hex).scanHexInt64(&int)
             let a, r, g, b: UInt64
             switch hex.count {
             case 3: // RGB (12-bit)
                 (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
             case 6: // RGB (24-bit)
                 (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
             case 8: // ARGB (32-bit)
                 (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
             default:
                 (a, r, g, b) = (255, 0, 0, 0)
             }
             self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
    
    static var primaryColor : UIColor {
        return UIColor(hexString: "2f3640")
    }
    
    static var secondaryColor : UIColor {
        return UIColor(hexString: "353b48")
    }
    
    static var subtitleColor : UIColor {
        return UIColor(hexString: "6a7c8f")
    }
    
    static var redColor : UIColor {
        return UIColor(hexString: "e74c3c")
    }
    
    static var detailsColor : UIColor {
        return UIColor(hexString: "ecf0f1")
    }
}
