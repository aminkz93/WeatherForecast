//
//  HourlyDisplayViewController.swift
//  WeatherForecast
//
//  Created by Amin on 2021-10-06.
//

import UIKit
import Charts


class HourlyDisplayViewController: UIViewController {

    var hourlyData: [Double]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var barChart = BarChartView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
        
        var entries = [BarChartDataEntry]()
        
        for i in 0...23 {
            entries.append(BarChartDataEntry(x: Double(i), y: hourlyData![i]))
        }
        var set = BarChartDataSet(entries: entries, label: "Temperature")
        
        var data = BarChartData(dataSet: set)
        
        barChart.data = data
        view.addSubview(barChart)
        barChart.center = view.center
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
