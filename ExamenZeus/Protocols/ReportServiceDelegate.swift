//
//  ReportServiceDelegate.swift
//  ExamenZeus
//
//  Created by Carolina Carapia on 30/07/22.
//

import Foundation

protocol ReportServiceDelegate {
    func getReport<T: Decodable>(completion: @escaping ResultCallback<T>)
    func getColor<T: Decodable>(completion: @escaping ResultCallback<T>)
}
