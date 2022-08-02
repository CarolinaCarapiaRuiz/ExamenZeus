//
//  String+isNil.swift
//  ExamenZeus
//
//  Created by Carolina Carapia on 02/08/22.
//

import Foundation

extension String {
    var isNil: Bool {
        return self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
