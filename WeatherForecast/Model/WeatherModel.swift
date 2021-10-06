//
//  WeatherModel.swift
//  WeatherForecast
//
//  Created by Amin on 2021-10-05.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let minTemp: Double
    let maxTemp: Double
    let time: TimeInterval
    var hourlyData: [Double]?
    
    
    var date: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none

        let dateTime = formatter.string(from: Date(timeIntervalSince1970: time))
        var temp = dateTime.split(separator: ",")
        
        return String("\(temp[0]) \(temp[1])")
    }
    
    var minTempratureString: String {
        return String(format: "%.0f", minTemp)
    }
    var maxTempratureString: String {
        return String(format: "%.0f", maxTemp)
    }
    
    func selfPrint(){
        print("-------------------------------")
        let dateTime = Date(timeIntervalSince1970: time)

        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none

        let datetime = formatter.string(from: dateTime)
        print(datetime)
        print("min at: \(minTempratureString)")
        print("max at: \(maxTempratureString)")
        print(conditionName)
    }
    
    
    var conditionName: String {
        switch conditionId {
        case 200..<300:
            return "wind"
        case 300..<400:
            return "cloud.drizzle"
        case 500..<600:
            return "cloud.rain"
        case 600..<700:
            return "cloud.snow"
        case 700..<800:
            return "thermometer"
        case 800:
            return "sun.max"
        case 801..<900:
            return "cloud"
        default:
            return "sun.min"
        }
    }
}
