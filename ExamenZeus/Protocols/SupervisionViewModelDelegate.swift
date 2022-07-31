//
//  SupervisionViewModelDelegate.swift
//  ExamenZeus
//
//  Created by Carolina Carapia on 31/07/22.
//

import UIKit

protocol SupervisionViewModelDelegate {
    func setupTableViewCell(_ indexPath: IndexPath, _ tableView: UITableView) -> SupervisionTableViewCell
}
