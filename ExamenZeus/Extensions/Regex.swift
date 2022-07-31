//
//  Regex.swift
//  ExamenZeus
//
//  Created by Carolina Carapia on 30/07/22.
//

import UIKit

extension UITextField {
    
    func isValid(_ text: String) -> Bool {
        let regex = "[A-Za-z ]*$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: text)
    }
}
