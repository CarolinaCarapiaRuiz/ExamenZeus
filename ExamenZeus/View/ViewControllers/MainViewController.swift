//
//  MainViewController.swift
//  ExamenZeus
//
//  Created by Carolina Carapia on 30/07/22.
//

import UIKit

class MainViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell().identifier)
        return tableView
    }()
    
    private var imagePicker: UIImagePickerController!
    private var takeSelfie: UIImageView?
    private var viewModel: MainViewModelDelegate!
    
    init(viewModel: MainViewModelDelegate) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTableView()
        constraints()
        setButton()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    private func setButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Color", style: .plain, target: self, action: #selector(addTapped))
    }
    
    @objc private func addTapped() {
        viewModel.getColor(completionSuccess: { [weak self] screenColor in
            self?.tableView.backgroundColor = UIColor(named: screenColor.color)
        }, completionFailure: { [weak self] error in
            self?.showAlert(title: error.localizedDescription)
        })
    }
    
    func constraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TypeCell.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = viewModel.setupTableViewCell(indexPath, tableView)
        return cell
    }
}

extension MainViewController: UITableViewDelegate, UINavigationControllerDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let typeCell = TypeCell(rawValue: indexPath.row) else { return }
        didSelectTableViewCell(typeCell)
    }
    
    private func didSelectTableViewCell(_ typeCell: TypeCell) {
        switch typeCell {
        case .textField:
            break
        case .selfie:
            showAlert()
        case .text:
            viewModel.getReport(completionSuccess: { [weak self] resultReport in
                self?.showSupervisionDetail(resultReport)
            }, completionFailure: { [weak self] error in
                self?.showAlert(title: error.localizedDescription)
            })
        }
    }
    
    private func showSupervisionDetail(_ resultReport: ResultReport) {
        let supervisionViewModel = SupervisionViewModel(resultReport: resultReport)
        let viewController = SupervisionViewController(viewModel: supervisionViewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func showAlert() {
        showAlert(title: Constants.titleAlertSelfie, simpleAlert: false, titleActionOne: Constants.takePhoto, handerActionOne: { [weak self] in
            self?.takePhoto()
        }, titleActionTwo: Constants.viewLibrary, handerActionTwo: { [weak self] in
            self?.viewPhotoLibrary()
        })
    }
    
    private func takePhoto() {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true)
    }
    
    private func viewPhotoLibrary() {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
}

extension MainViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        takeSelfie?.image = image
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true)
    }
    
}

