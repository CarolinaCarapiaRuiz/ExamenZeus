//
//  ReportService.swift
//  ExamenZeus
//
//  Created by Carolina Carapia on 30/07/22.
//

import Foundation
import UIKit
import FirebaseFirestore

final class ReportService: ReportServiceDelegate {

    private var service: NetworkService
    private let decoder: JSONDecoder
    
    init(
        service: NetworkService = NetworkService.shared,
        decoder: JSONDecoder = JSONDecoder()) {
        self.service = service
            self.decoder = decoder
            decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func getReport<T: Decodable>(completion: @escaping ResultCallback<T>) {
        let reportEndpoint = ReportEndpoint()
        service.request(reportEndpoint) { result in
            completion(result)
        }
    }
    
    func getColor<T: Decodable>(completion: @escaping ResultCallback<T>) {
        let db = Firestore.firestore()
        db.collection("screen").getDocuments() { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                for document in querySnapshot!.documents {
                    completion(self.decoded(T.self, json: document.data()))
                }
            }
        }
    }
    
    func decoded<T: Decodable>(_ type: T.Type, json: Any) -> Result<T> {
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let object = try decoder.decode(type, from: data)
            return .success(object)
        } catch {
            return .failure(NetworkError.decodingFailed)
        }
    }
    
}
