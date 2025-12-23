//
//  CurrencyType.swift
//  LOTR
//
//  Created by Yan  on 19/12/2025.
//
import DeveloperToolsSupport

enum CurrencyType : Double, CaseIterable{
    case GoldPiece = 6400
    case GoldPenny = 1600
    case SilverPiece = 400
    case SilverPenny = 100
    case CopperPenny = 1.0
    
    func convertToString(_ value:Double, to other: CurrencyType)->String{
        String(format: "%.2f",convert(value, to: other) as Double)
    }
    func convert(_ value:Double, to other: CurrencyType)->Double{
        (self.rawValue/other.rawValue)*value
    }
    var name:String {
        getName()
    }
    func getName(_ plural:Bool = false)-> String {
        let _piece = plural ? "pieces": "piece"
        let _penny = plural ? "pennies": "penny"
        
        return switch self{
           
        case .GoldPiece:
            "Golden \(_piece)"
        case .GoldPenny:
            "Golden \(_penny)"
        case .SilverPiece:
            "Silver \(_piece)"
        case .SilverPenny:
            "Silver \(_penny)"
        case .CopperPenny:
            "Copper \(_penny)"
        }
    }
    var image:ImageResource{
        return switch self{
            
        case .GoldPiece:
                .goldpiece
        case .GoldPenny:
                .goldpenny
        case .SilverPiece:
                .silverpiece
        case .SilverPenny:
                .silverpenny
        case .CopperPenny:
                .copperpenny
        }
    }
}
