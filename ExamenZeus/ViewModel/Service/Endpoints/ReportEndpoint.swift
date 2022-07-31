//
//  ReportEndpoint.swift
//  ExamenZeus
//
//  Created by Carolina Carapia on 30/07/22.
//

import Foundation

struct ReportEndpoint: Endpoint {
    var baseUrl: String {
        return "https://s3.amazonaws.com"
    }
    
    var httpMethod: HTTPMethod {
        .get
    }
    
    var path: String {
        return "/dev.structure.files/examen/ios/test.json"
    }
    
}
