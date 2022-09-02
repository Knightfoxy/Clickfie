//
//  String_Extension.swift
//  ClickFie
//
//  Created by Ayush Mishra on 16/05/22.
//

import Foundation
import UIKit

extension String {
    func isValidEmail() -> Bool {
        if let regex = try? NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: .caseInsensitive) {
            return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
        }
        return false
    }
    var isValidName: Bool {
        let regEx = "^(?=.{2,100}$)[A-Za-zÀ-ú][A-Za-zÀ-ú.'-]+(?: [A-Za-zÀ-ú.'-]+)* *$"
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: self)
    }
    func isValidMobileNo(mobNum : String) -> Bool {
        let PHONE_REGEX = "^[0-9]{9}$"
        let phoneTest = NSPredicate(format : "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with : mobNum)   // result evaluates mobile number
        return result
    }
    // To check text field or String is blank or not
    var isBlank : Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
}
    // Validate Email
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0,length: self.count)) != nil
        } catch {
            return false
        }
    }
    var isNumeric: Bool {
        return  range(of: "[^0-9]", options: .regularExpression) == nil
    }
    var isAlphabets: Bool {
        return  range(of: "[^a-zA-Z]", options: .regularExpression) == nil
    }
}
