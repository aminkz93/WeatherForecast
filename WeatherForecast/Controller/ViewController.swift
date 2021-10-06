//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Amin on 2021-10-04.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var cityNameTextField: UITextField!
    
    
    
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    var weatherDaily: [WeatherModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        cityNameTextField.delegate = self
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        
        if let city = cityNameTextField.text {
            weatherManager.fetchWeather(city)
        }
        cityNameTextField.text = ""
        
        
    }
    
    @IBAction func useGPSPressed(_ sender: UIButton) {
        print("gps request sent")
        locationManager.requestLocation()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare method got called")
        if segue.identifier == "fiveDaySegue" {
            let destinationVC = segue.destination as! FiveDayForecastViewController
            destinationVC.weatherDaily = weatherDaily
            print("data being sent to new VC")
        }
    }
}

//MARK: - CLLocaionManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("cllocationmanagerdelegate got called")
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longtitude: lon)
            print("fetch wether by coordinate got called")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}


//MARK: - WeatherManagerDelegate

extension ViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: [WeatherModel]) {
        
        weatherDaily = weather
        DispatchQueue.main.async {
            self.locationManager.stopUpdatingLocation()
            print("location stopped updating")
            print("fivedaysegue is gonna get called")
            self.performSegue(withIdentifier: "fiveDaySegue", sender: self)
        }
        
        
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        print("1")
        cityNameTextField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        print("2")
        if textField.text != "" {
            cityNameTextField.placeholder = "Type a city name"
            return true
        } else {
            cityNameTextField.placeholder = "Cannot be empty!"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        print("3")
        if let city = cityNameTextField.text {
            weatherManager.fetchWeather(city)
        }
        cityNameTextField.text = ""
    }
}

