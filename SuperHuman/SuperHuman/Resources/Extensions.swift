import UIKit

extension UIColor {
    static func hex(_ hexString: String, defaultColor: UIColor = .black) -> UIColor {
        var cleanedHex = hexString
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .uppercased()
        
        if cleanedHex.hasPrefix("#") {
            cleanedHex.remove(at: cleanedHex.startIndex)
        }
        
        let allowedCharacters = CharacterSet(charactersIn: "0123456789ABCDEF")
        guard cleanedHex.rangeOfCharacter(from: allowedCharacters.inverted) == nil else {
            print("⚠️ HEX содержит недопустимые символы: \(hexString)")
            return defaultColor
        }
        
        var hexNumber: UInt64 = 0
        let scanner = Scanner(string: cleanedHex)
        
        guard scanner.scanHexInt64(&hexNumber) else {
            print("⚠️ Не удалось распознать HEX: \(hexString)")
            return defaultColor
        }
        
        let a, r, g, b: UInt64
        
        switch cleanedHex.count {
        case 3:
            (a, r, g, b) = (
                255,
                (hexNumber >> 8) & 0xF,
                (hexNumber >> 4) & 0xF,
                (hexNumber) & 0xF
            )
            
            return UIColor(
                red: CGFloat(r * 17) / 255,
                green: CGFloat(g * 17) / 255,
                blue: CGFloat(b * 17) / 255,
                alpha: 1.0
            )
            
        case 4:
            (a, r, g, b) = (
                (hexNumber >> 12) & 0xF,
                (hexNumber >> 8) & 0xF,
                (hexNumber >> 4) & 0xF,
                (hexNumber) & 0xF
            )
            return UIColor(
                red: CGFloat(r * 17) / 255,
                green: CGFloat(g * 17) / 255,
                blue: CGFloat(b * 17) / 255,
                alpha: CGFloat(a * 17) / 255
            )
            
        case 6:
            (a, r, g, b) = (
                255,
                (hexNumber >> 16) & 0xFF,
                (hexNumber >> 8) & 0xFF,
                (hexNumber) & 0xFF
            )
            
        case 8:
            (a, r, g, b) = (
                (hexNumber >> 24) & 0xFF,
                (hexNumber >> 16) & 0xFF,
                (hexNumber >> 8) & 0xFF,
                (hexNumber) & 0xFF
            )
            
        default:
            print("⚠️ Неподдерживаемый формат HEX: \(hexString)")
            return defaultColor
        }
        
        return UIColor(
            red: CGFloat(r) / 255,
            green: CGFloat(g) / 255,
            blue: CGFloat(b) / 255,
            alpha: CGFloat(a) / 255
        )
    }
}
