//
//  WeatherManager.swift
//  WeatherForecast
//
//  Created by Amin on 2021-10-04.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: [WeatherModel])
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/onecall?appid=f2a8758b26a5648379b4bd4dc1ef20b0&units=metric&exclude=minutely"
    var delegate: WeatherManagerDelegate?
    var locationManager = CLLocationManager()
    
    func fetchWeather(_ cityName: String){
        getCoordinate(addressString: cityName, completionHandler: { (coordinate, error) in
            
            if error != nil{
                print("Error in getting coordinate \(error)")
            } else {
                print("retrieved successfully")
                let latitude = coordinate.latitude
                let longtitude = coordinate.longitude
                let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longtitude)"
                performRequest(with: urlString)
            }
        })
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longtitude: CLLocationDegrees){
        
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longtitude)"
        performRequest(with: urlString)
        print("perform url request sent")
        
    }
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){
                        print("data fetchd and delegate gonna get called")
                        delegate?.didUpdateWeather(self, weather: weather)
                        
//                                                for day in weather{
//                                                    day.selfPrint()
//                                                }
                    }
                }
                
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> [WeatherModel]?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print("----------------------------------")
            print(decodedData.hourly)
            print("----------------------------------")

            var weatherModels = [WeatherModel]()
            
            let daily = decodedData.daily
            for day in daily{
                weatherModels.append(WeatherModel(conditionId: day.weather[0].id, minTemp: day.temp.min, maxTemp: day.temp.max, time: day.dt, hourlyData: nil))
            }
            
            var hourly = [Double]()
            for hour in 0...23 {
                hourly.append(decodedData.hourly[hour].temp)
            }
            print("----------------------------------")
            print(hourly)
            print("----------------------------------")
            weatherModels[0].hourlyData = hourly
            
            hourly.removeAll()
            for hour in 24...47 {
                hourly.append(decodedData.hourly[hour].temp)
            }
            print("----------------------------------")
            print(hourly)
            print("----------------------------------")
            weatherModels[1].hourlyData = hourly
            
            return weatherModels
            
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
    
    func getCoordinate( addressString : String,
                        completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
            
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
    
    
    
}
