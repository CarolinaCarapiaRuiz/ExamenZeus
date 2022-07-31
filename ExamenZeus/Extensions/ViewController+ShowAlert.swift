//
//  ViewController+ShowAlert.swift
//  ExamenZeus
//
//  Created by Carolina Carapia on 30/07/22.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String? = nil, simpleAlert: Bool = true, titleActionOne: String? = nil, handerActionOne: (() -> Void)? = nil, titleActionTwo: String? = nil, handerActionTwo: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if simpleAlert {
            let alertAction = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alertController.addAction(alertAction)
        } else {
            let alertActionOne = UIAlertAction(title: titleActionOne ?? "Cancelar", style: .default, handler: { _ in
                guard let handerActionOne = handerActionOne else {
                    return
                }
                handerActionOne()
            })
            let alertActionTwo = UIAlertAction(title: titleActionTwo ?? "Aceptar", style: .default, handler: { _ in
                guard let handerActionTwo = handerActionTwo else {
                    return
                }
                handerActionTwo()
            })
            
            alertController.addAction(alertActionOne)
            alertController.addAction(alertActionTwo)
        }
        
        present(alertController, animated: true)
        
    }
    
}
