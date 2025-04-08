//
//  Color.swift
//  fridge-app
//
//  Created by Franchovy on 08/04/25.
//

import UIKit

extension UIColor {
    public convenience init?(hex: String) {
            let r, g, b, a: CGFloat
            
            guard hex.hasPrefix("#") else {
                return nil
            }
            
            let hexValue = hex.replacingOccurrences(of: "#", with: "")
        
            guard hexValue.count == 8 || hexValue.count == 6 else {
                return nil
            }
        
        let isAlpha = hexValue.count == 8;
        
            let scanner = Scanner(string: hexValue)
            var hexNumber: UInt64 = 0
            
            guard scanner.scanHexInt64(&hexNumber) else {
                return nil
            }
            r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
            g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
            b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
        a = isAlpha ? CGFloat(hexNumber & 0x000000ff) / 255 : 1.0
            
            self.init(red: r, green: g, blue: b, alpha: a)
            return
        }
}
