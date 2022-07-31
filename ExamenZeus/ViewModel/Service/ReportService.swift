//
//  ReportService.swift
//  ExamenZeus
//
//  Created by Carolina Carapia on 30/07/22.
//

import Foundation
import UIKit

final class ReportService: ReportServiceDelegate {
    
    private var service: NetworkService
    
    init(service: NetworkService = NetworkService.shared) {
        self.service = service
    }
    
    func getReport<T: Decodable>(completion: @escaping ResultCallback<T>) {
        let reportEndpoint = ReportEndpoint()
        service.request(reportEndpoint) { result in
            completion(result)
        }
    }
    
}
