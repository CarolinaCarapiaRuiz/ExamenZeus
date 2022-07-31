//
//  CustomTableViewCell.swift
//  ExamenZeus
//
//  Created by Carolina Carapia on 30/07/22.
//

import UIKit

final class CustomTableViewCell: UITableViewCell{
    
    var identifier: String = "CustomTableViewCell"
    
    lazy var selfieButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.setImage(
            UIImage(systemName: "camera.on.rectangle.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal),
            for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .alphabet
        textField.placeholder = Constants.fullName
        textField.isEnabled = true
        return textField
    }()
    
    lazy var titleLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .justified
        return textLabel
    }()
    
    struct K {
        static let height: CGFloat = 50
        static let verticalSpace: CGFloat = 20
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func titleLabelConstraints() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: K.verticalSpace),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -K.verticalSpace)
        ])
    }
    
    func textFieldConstraints() {
        textField.delegate = self
        addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.heightAnchor.constraint(equalToConstant: K.height),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: K.verticalSpace),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -K.verticalSpace)
        ])
    }
    
    func selfieButtonConstraints() {
        addSubview(selfieButton)
        NSLayoutConstraint.activate([
            selfieButton.topAnchor.constraint(equalTo: topAnchor),
            selfieButton.heightAnchor.constraint(equalToConstant: K.height * 2),
            selfieButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            selfieButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: K.verticalSpace),
            selfieButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -K.verticalSpace)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CustomTableViewCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField.isValid(string) else { return false }
        return true
    }
    
}
