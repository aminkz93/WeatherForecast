//
//  RegisterViewController.swift
//  WeatherForecast
//
//  Created by Amin on 2021-10-06.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let password = passwordTextField.text, let email = emailTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print("error occured")
                    print(e.localizedDescription)
                    print(e)
                }else {
                    self.performSegue(withIdentifier: "registerToMain" , sender: self)
                }
            }
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
