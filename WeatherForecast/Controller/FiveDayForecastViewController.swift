//
//  FiveDayForecastViewController.swift
//  WeatherForecast
//
//  Created by Amin on 2021-10-05.
//

import UIKit

class FiveDayForecastViewController: UIViewController {

    @IBOutlet weak var hourlyButton1: UIButton!
    @IBOutlet weak var highLabel1: UILabel!
    @IBOutlet weak var lowLabel1: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var dateLabel1: UILabel!
    
    @IBOutlet weak var dateLabel2: UILabel!
    @IBOutlet weak var hourlyButton2: UIButton!
    @IBOutlet weak var highLabel2: UILabel!
    @IBOutlet weak var lowLabel2: UILabel!
    @IBOutlet weak var image2: UIImageView!
    
    @IBOutlet weak var dateLabel3: UILabel!
    @IBOutlet weak var highLabel3: UILabel!
    @IBOutlet weak var lowLabel3: UILabel!
    @IBOutlet weak var image3: UIImageView!
    
    @IBOutlet weak var dateLabel4: UILabel!
    @IBOutlet weak var highLabel4: UILabel!
    @IBOutlet weak var lowLabel4: UILabel!
    @IBOutlet weak var image4: UIImageView!
    
    @IBOutlet weak var dateLabel5: UILabel!
    @IBOutlet weak var highLabel5: UILabel!
    @IBOutlet weak var lowLabel5: UILabel!
    @IBOutlet weak var image5: UIImageView!
    
    
    var weatherDaily: [WeatherModel]?
    var hourly: [Double]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let daily = weatherDaily {
            //print("data tryna get into ui")
            hourlyButton1.setTitle("hourly forecast", for: .normal)
            highLabel1.text = "High: \(daily[0].maxTempratureString)"
            lowLabel1.text = "Low: \(daily[0].minTempratureString)"
            image1.image = UIImage(systemName: daily[0].conditionName)
            dateLabel1.text = daily[0].date
            
            
            
            hourlyButton2.setTitle("hourly forecast", for: .normal)
            highLabel2.text = "High: \(daily[1].maxTempratureString)"
            lowLabel2.text = "Low: \(daily[1].minTempratureString)"
            image2.image = UIImage(systemName: daily[1].conditionName)
            dateLabel2.text = daily[1].date
            
            
            highLabel3.text = "High: \(daily[2].maxTempratureString)"
            lowLabel3.text = "Low: \(daily[2].minTempratureString)"
            image3.image = UIImage(systemName: daily[2].conditionName)
            dateLabel3.text = daily[2].date
            
            
            highLabel4.text = "High: \(daily[3].maxTempratureString)"
            lowLabel4.text = "Low: \(daily[3].minTempratureString)"
            image4.image = UIImage(systemName: daily[3].conditionName)
            dateLabel4.text = daily[3].date
            
            highLabel5.text = "High: \(daily[4].maxTempratureString)"
            lowLabel5.text = "Low: \(daily[4].minTempratureString)"
            image5.image = UIImage(systemName: daily[4].conditionName)
            dateLabel5.text = daily[4].date
        }
    }
    

    @IBAction func hourlyPressed(_ sender: UIButton) {
        if sender.tag == 0 {
            
            hourly = weatherDaily![0].hourlyData
            self.performSegue(withIdentifier: "hourlySegue", sender: self)
        }else if sender.tag == 1 {
            hourly = weatherDaily![1].hourlyData
            self.performSegue(withIdentifier: "hourlySegue", sender: self)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "hourlySegue" {
            let destinationVC = segue.destination as! HourlyDisplayViewController
            destinationVC.hourlyData = hourly
        }
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
