//
//  Theme.swift
//  fridge-app
//
//  Created by Franchovy on 08/04/25.
//

import UIKit

class Theme {
    class Constants {
        static let marginTiny: CGFloat = 4.0
        static let marginSmall: CGFloat = 8.0
        static let marginMedium: CGFloat = 12.0
        static let marginLarge: CGFloat = 16.0
        static let marginGiant: CGFloat = 24.0
        static let marginHuge: CGFloat = 32.0
    }
    
    class Color {
        static let primary: CGColor! = UIColor(hex: "#275B46")?.cgColor
        static let onPrimary: CGColor! = UIColor(hex: "#FFFFFF")?.cgColor
        
        static let accent: CGColor! = UIColor(hex: "#F1B644")?.cgColor
        static let onAccent: CGColor! = UIColor(hex: "#000000")?.cgColor
        
        static let onSurface: CGColor! = UIColor(hex: "#000000")?.cgColor
        static let onSurfaceSecondary: CGColor! = UIColor(hex: "#333333")?.cgColor
        static let onSurfaceTertiary: CGColor! = UIColor(hex: "#737373")?.cgColor
        
        static let secondary: CGColor! = UIColor(hex: "#BECEC7")?.cgColor
        static let surface: CGColor! = UIColor(hex: "#FFFFFF")?.cgColor
        static let surfaceSecondary: CGColor! = UIColor(hex: "#EBEBEB")?.cgColor
        static let surfaceSecondaryAlt: CGColor! = UIColor(hex: "#EAF2F1")?.cgColor
    }
    
    class Font {
        static let appFont1: UIFont! = .init(name: "AvenirLTStd-Light", size: 16)
        static let appFont2: UIFont! = .init(name: "AvenirLTStd-Heavy", size: 16)
        
        static let title: UIFont! = .init(name: "AvenirLTStd-Heavy", size: 24)
        static let titleSmall: UIFont! = .init(name: "AvenirLTStd-Heavy", size: 16)
        
        static let body: UIFont! = .init(name: "AvenirLTStd-Roman", size: 16)
        
        static let label: UIFont! = .init(name: "AvenirLTStd-Roman", size: 12)
        static let labelMedium: UIFont! = .init(name: "AvenirLTStd-Medium", size: 12)
        static let labelLarge: UIFont! = .init(name: "AvenirLTStd-Heavy", size: 14)
        
        static let content: UIFont! = .init(name: "AvenirLTStd-Medium", size: 14)
        static let indicator: UIFont! = .init(name: "AvenirLTStd-Heavy", size: 18)
    }
}
