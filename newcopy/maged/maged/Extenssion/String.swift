//
//  String.swift
//  Challenge_App
//
//  Created by khaled saad on 9/25/17.
//  Copyright © 2017 Asgatech. All rights reserved.
//

import Foundation

//extension String {
//
//    func size(_ font: UIFont) -> CGSize {
//        return NSAttributedString(string: self, attributes: [NSFontAttributeName: font]).size()
//    }
//
//    func width(_ font: UIFont) -> CGFloat {
//        return size(font).width
//    }
//
//    func height(_ font: UIFont) -> CGFloat {
//        return size(font).height
//    }
//}
extension String {
    
    
//    func size(OfFont font: UIFont) -> CGSize {
//        return (self as NSString).size(attributes: [NSFontAttributeName: font])
//    }
    
    
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
//    subscript (r: Range<Int>) -> String {
//        let start = index(startIndex, offsetBy: r.lowerBound)
//        let end = index(startIndex, offsetBy: r.upperBound)
//        return self[Range(start ..< end)]
//    }
    
    
    func toDateTime() -> Date {
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        
        //Specify Format of String to Parse
        //        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss"
        dateFormatter.dateFormat = "EEE, d MMM yyyy HH:mm:ss Z"
        
        //Parse into NSDate
        let dateFromString : Date = dateFormatter.date(from: self)!
        
        //Return Parsed Date
        return dateFromString
    }
    
    
    
    
    func toDateOnly() -> Date {
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        
        //Specify Format of String to Parse
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        //Parse into NSDate
        let dateFromString : Date = dateFormatter.date(from: self)!
        
        //Return Parsed Date
        return dateFromString
    }
    
    
    
    
    
    
    func toDate() -> Date {
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        
        //Specify Format of String to Parse
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        print(self)
        
        
        //Parse into NSDate
        let dateFromString : Date = dateFormatter.date(from: self)!
        
        //Return Parsed Date
        return dateFromString
    }
    
    func toGregorianDate() -> Date {
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        
        //Specify Format of String to Parse
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        print(self)
        
        
        //Parse into NSDate
        let dateFromString : Date = dateFormatter.date(from: self)!
        
        //Return Parsed Date
        return dateFromString
    }
    
    
    func toHijriDate() -> Date {
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        
        //Specify Format of String to Parse
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        print(self)
        
        
        //Parse into NSDate
        let dateFromString : Date = dateFormatter.date(from: self)!
        
        //Return Parsed Date
        return dateFromString
    }
    
    
    
    
    
    func toTime() -> Date {
        //Create Date Formatter
        let timeFormatter = DateFormatter()
        
        //Specify Format of String to Parse
        timeFormatter.dateFormat = "hh:mm:ss"
        
        //Parse into NSDate
        let timeFromString : Date = timeFormatter.date(from: self)!
        
        //Return Parsed Date
        return timeFromString
    }
    
}
extension String {
    
    var isValidEmail: Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var isPhoneNumber: Bool {
        if self.count != 8 {
            return false
        }
        if self.first == "5" && self[1] == "0"  {
            return true
        }
        return false
        
    }
    
    public var initials: String {
        
        var finalString = String()
        var words = components(separatedBy: .whitespacesAndNewlines)
        
        if let firstCharacter = words.first?.first {
            finalString.append(String(firstCharacter))
            words.removeFirst()
        }
        
        if let lastCharacter = words.last?.first {
            finalString.append(String(lastCharacter))
        }
        
        return finalString.uppercased()
    }
//    func formattedServerDate(format : String = "yyyy-MM-dd" ) -> String {
//        return self.date().string(custom: format)
//    }
//    func date(format : String = "yyyy-MM-dd'T'HH:mm:ss" ) -> Date {
//        return Date.datefrom(string: self.components(separatedBy: ["."]).first!, format: format)
//    }
    
    var intValue : Int {
        
        let arr = ["٠","١","٢","٣","٤","٥","٦","٧","٨","٩"]
        
        var result = self
        
        for int in 0...9 {
            result = result.replacingOccurrences(of: arr[int], with:String(int) )
        }
        result = result.replacingOccurrences(of: " \("SAR".localized)", with:"" )
        
        return Int(result)!
    }
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    var englishPhoneNumber : String {
        
        let arr = ["٠","١","٢","٣","٤","٥","٦","٧","٨","٩"]
        
        var result = self
        
        for int in 0...9 {
            result = result.replacingOccurrences(of: arr[int], with:String(int) )
        }
        
        return result
    }
    
}
