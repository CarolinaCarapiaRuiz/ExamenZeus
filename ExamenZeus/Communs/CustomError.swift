//
//  CustomError.swift
//  ExamenZeus
//
//  Created by Carolina Carapia on 02/08/22.
//

import Foundation

enum CustomError: Error {
    case invalidName
    case invalidImage
}

extension CustomError: CustomStringConvertible {
    var description: String {
        switch self {
        case .invalidName:
            return "Por favor ingrese su nombre"
        case .invalidImage:
            return "Antes de enviar los datos debe tomar una foto"
        }
    }
}
