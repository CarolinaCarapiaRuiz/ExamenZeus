//
//  ResultReport.swift
//  ExamenZeus
//
//  Created by Carolina Carapia on 30/07/22.
//

import Foundation

struct ResultReport: Decodable {
    var reporte: [Report]
    var empresas: [Company]
}
