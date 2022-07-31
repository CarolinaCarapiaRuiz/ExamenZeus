//
//  SupervisionTableViewCell.swift
//  ExamenZeus
//
//  Created by Carolina Carapia on 31/07/22.
//

import UIKit
import Charts

final class SupervisionTableViewCell: UITableViewCell {
    
    var identifier: String = "SupervisionTableViewCell"
    
    lazy var titleLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.font = UIFont.boldSystemFont(ofSize: 20)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .justified
        return textLabel
    }()
    
    struct K {
        static let height: CGFloat = 50
        static let verticalSpace: CGFloat = 20
    }
    
    var chartView: PieChartView = {
        let chart = PieChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        return chart
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(chartView)
        chartView.delegate = self
        self.constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraints() {
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: K.height),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: K.verticalSpace),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -K.verticalSpace)
        ])
        
        NSLayoutConstraint.activate([
            chartView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            chartView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -K.verticalSpace),
            chartView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: K.verticalSpace),
            chartView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -K.verticalSpace),
        ])
        
    }
    
}

extension SupervisionTableViewCell: ChartViewDelegate { }
