//
//  MainViewModel.swift
//  ExamenZeus
//
//  Created by Carolina Carapia on 30/07/22.
//

import UIKit
import FirebaseFirestore

final class MainViewModel: MainViewModelDelegate {
    
    private var reportService: ReportServiceDelegate

    private var image: String? {
        reportService.loadSelfie()
    }
    
    init(service: ReportServiceDelegate) {
        self.reportService = service
    }
    
    func getReport(completionSuccess: @escaping (ResultReport) -> Void?, completionFailure: @escaping (Error) -> Void?) {
        reportService.getReport(completion: { (result: Result<ResultReport>) in
            switch result {
            case .success(let resultReport):
                completionSuccess(resultReport)
            case .failure(let error):
                completionFailure(error)
            }
        })
    }
    
    func setupTableViewCell(_ indexPath: IndexPath, _ tableView: UITableView) -> CustomTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell().identifier, for: indexPath) as? CustomTableViewCell else { return CustomTableViewCell() }
        cell.selectionStyle = .none
        switch TypeCell(rawValue: indexPath.row) {
        case .textField:
            cell.textFieldConstraints()
            cell.textField.becomeFirstResponder()
        case .selfie:
            cell.selfieButtonConstraints()
        case .text:
            cell.titleLabelConstraints()
            cell.titleLabel.text = Constants.thirdCellParagraph
        case .none:
            break
        }
        return cell
    }
    
    func getColor(completionSuccess: @escaping (ScreenColor) -> Void?, completionFailure: @escaping (Error) -> Void?) {
        reportService.getColor(completion: { (result: Result<ScreenColor>) in
            switch result {
            case .success(let resultReport):
                completionSuccess(resultReport)
            case .failure(let error):
                completionFailure(error)
            }
        })
    }
    
    func saveSelfie(image: UIImage) {
        reportService.saveSelfie(image)
    }
    
    func sendUser( _ tableView: UITableView, completionFailure: @escaping (CustomError) -> Void?) {
        
        let index = IndexPath(row: TypeCell.textField.rawValue, section: 0)
        let cell = tableView.cellForRow(at: index) as! CustomTableViewCell
        
        guard let name = cell.textField.text, !name.isNil else {
            completionFailure(CustomError.invalidName)
            return
        }
        
        guard let image = image else {
            completionFailure(CustomError.invalidImage)
            return
        }
    
        let user = User(name: name, selfie: image)
        reportService.sendUser(user)
        
    }
    
}
