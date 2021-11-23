//
//  String+Extension.swift
//  PaySlipViewer
//
//  Created by karthik on 23/11/21.
//

import Foundation
import UIKit

extension String {
    
    func getSubString( from:Int, to:Int)-> String {
        let subStart = self.index(self.startIndex, offsetBy: from)
        let subEnd = self.index(self.startIndex, offsetBy: to)
        return String(self[subStart ..< subEnd])
    }
    
    func charAt(at: Int) -> Character {
        let charIndex = self.index(self.startIndex, offsetBy: at)
        return self[charIndex]
    }
    
    //MARK: for language change
    var localized: String {
        var selectedLang = "en"
        if let lang = getAppLanguage() {
            selectedLang = lang
        }
        let path = Bundle.main.path(forResource: selectedLang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    
    func isValidEmail() -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: self)
    }

    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
}
