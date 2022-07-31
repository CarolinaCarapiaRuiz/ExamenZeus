//
//  SupervisionViewModel.swift
//  ExamenZeus
//
//  Created by Carolina Carapia on 31/07/22.
//

import Charts

final class SupervisionViewModel: SupervisionViewModelDelegate {
    
    private var resultReport: ResultReport
    
    init(resultReport: ResultReport) {
        self.resultReport = resultReport
    }
    
    func setupTableViewCell(_ indexPath: IndexPath, _ tableView: UITableView) -> SupervisionTableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SupervisionTableViewCell().identifier, for: indexPath) as? SupervisionTableViewCell else { return SupervisionTableViewCell() }
        setup(pieChartView: cell.chartView)
        
        if indexPath.row == 0 {
            
            cell.titleLabel.text = Constants.titleReport
            setDataCount(
                resultReport.reporte.map { $0.valor },
                range: resultReport.reporte.map { Int($0.cantidad) ?? 0 },
                chartView: cell.chartView)
            
        } else {
            
            cell.titleLabel.text = Constants.titleCompany
            setDataCount(
                resultReport.empresas.map { $0.nombre },
                range: resultReport.empresas.map { $0.porcentaje },
                chartView: cell.chartView)
            
        }
        return cell
        
    }
    
    private func setDataCount(_ dataPoints: [String], range: [Int], chartView: PieChartView) {
                
        let entries = (0..<dataPoints.count).map { (i) -> PieChartDataEntry in
            return PieChartDataEntry(value: Double(range[i]),
                                     label: dataPoints[i])
        }

        let pieChartDataSet = PieChartDataSet(entries: entries, label: "")
        pieChartDataSet.sliceSpace = 2
        pieChartDataSet.colors = ChartColorTemplates.vordiplom()
        + ChartColorTemplates.joyful()
        + ChartColorTemplates.colorful()
        + ChartColorTemplates.liberty()
        + ChartColorTemplates.pastel()
        + [UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)]

        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        
        pieChartData.setValueFont(.systemFont(ofSize: 11, weight: .light))
        pieChartData.setValueTextColor(.black)
        pieChartData.setDrawValues(true)

        chartView.data = pieChartData
        chartView.animate(yAxisDuration: 2.0, easingOption: .easeInBack)
        chartView.highlightValues(nil)
        
    }
    
    func setup(pieChartView chartView: PieChartView) {
        chartView.usePercentValuesEnabled = true
        chartView.drawSlicesUnderHoleEnabled = false
        chartView.holeRadiusPercent = 0.58
        chartView.transparentCircleRadiusPercent = 0.61
        chartView.chartDescription.enabled = false
        chartView.setExtraOffsets(left: 5, top: 10, right: 5, bottom: 5)
        
        chartView.drawCenterTextEnabled = true
        
                
        chartView.drawHoleEnabled = true
        chartView.rotationAngle = 0
        chartView.rotationEnabled = true
        chartView.highlightPerTapEnabled = true
        
        let l = chartView.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = true
        l.xEntrySpace = 15
        l.yEntrySpace = 0
        l.yOffset = 0
    }
    
}
