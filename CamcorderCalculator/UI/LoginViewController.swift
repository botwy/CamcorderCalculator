//
//  LoginViewController.swift
//  CamcorderCalculator
//
//  Created by Гончаров Денис Васильевич on 02.08.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, Calculatable {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    var calculationFabric: CalculationFabric?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: UIButton) {
        let userId = UUID().uuidString
        let userName = nameTextField.text ?? ""
        let userPhone = phoneTextField.text ?? ""
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(userId, forKey: "userId")
        userDefaults.set(userName, forKey: "userName")
        userDefaults.set(userPhone, forKey: "userPhone")
        FirebaseStore.shared.saveUser(id: userId, name: userName, phone: userPhone)
        performSegue(withIdentifier: "rootSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as? Calculatable
        controller?.calculationFabric = calculationFabric
    }

}
