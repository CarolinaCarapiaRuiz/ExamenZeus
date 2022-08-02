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
    
    func saveSelfie(_ image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        let encoded = try! PropertyListEncoder().encode(data)
        UserDefaults.standard.set(encoded, forKey: "selfie")
    }
    
    func loadSelfie() -> String? {
        guard let data = UserDefaults.standard.data(forKey: "selfie") else { return nil }
        let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
        guard let image = UIImage(data: decoded) else { return nil }
        return "\(image)"
    }
    
    func sendUser(_ user: User) {
        let db = Firestore.firestore()
        db.collection("usuarios").document().setData([
            "nombre": user.name,
            "foto": user.selfie
        ])
    }
    
}
