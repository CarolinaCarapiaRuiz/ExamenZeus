//
//  MainViewModelDelegate.swift
//  ExamenZeus
//
//  Created by Carolina Carapia on 30/07/22.
//

import UIKit

protocol MainViewModelDelegate {
    func getColor(completionSuccess: @escaping (ScreenColor) -> Void?, completionFailure: @escaping (Error) -> Void?)
    
    func getReport(completionSuccess: @escaping (ResultReport) -> Void?, completionFailure: @escaping (Error) -> Void? )
    
    func setupTableViewCell(_ indexPath: IndexPath, _ tableView: UITableView) -> CustomTableViewCell
}
