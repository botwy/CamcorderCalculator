//
//  ViewController.swift
//  CamcorderCalculator
//
//  Created by Гончаров Денис Васильевич on 31.07.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController, Calculatable {
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var cameraPriceSlider: UISlider!
    
    @IBOutlet weak var cameraPriceLbl: UILabel!
    
    @IBOutlet weak var cameraPriceSegment: UISegmentedControl!
    
    @IBOutlet weak var cameraAmountTextField: UITextField!
    
    @IBOutlet weak var registratorAmountTextField: UITextField!
    
    @IBOutlet weak var cableLengthTextField: UITextField!
    
    @IBOutlet weak var calculationResultContainerView: UIView!
    
    var calculationFabric: CalculationFabric?
    private var cameraPrice: Int?
    private var cameraPriceStep: Float = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let userDefaults = UserDefaults.standard
        cameraPriceSlider.minimumValue = userDefaults.float(forKey: "cameraPriceMin")
        cameraPriceSlider.maximumValue = userDefaults.float(forKey: "cameraPriceMax")
        cameraPriceStep = userDefaults.float(forKey: "cameraPriceStep")
        setupCameraPrice()
        
        FirebaseStore.shared.fetchCameraPriceRange {
            self.cameraPriceSlider.minimumValue = $0.min
            self.cameraPriceSlider.maximumValue = $0.max
            self.cameraPriceStep = $0.step
            self.setupCameraPrice()
        }
        calculationResultContainerView.isHidden = true
    }
    
    func setupCameraPrice() {
        cameraPrice = Int(round(cameraPriceSlider.value/cameraPriceStep)*cameraPriceStep)
        if let cameraPrice = cameraPrice {
        cameraPriceLbl.text = "\(cameraPrice) руб."
        }
    }
    
    @IBAction func cameraPriceDidChange(_ sender: UISlider) {
        setupCameraPrice()
    }
    
    @IBAction func clear(_ sender: UIBarButtonItem) {
        calculationResultContainerView.isHidden = true
        cameraAmountTextField.text = ""
        registratorAmountTextField.text = ""
        cableLengthTextField.text = ""
    }
    
    @IBAction func calculate(_ sender: UIBarButtonItem) {
        guard let calculationResultController = children.first as? CalculationResultViewController else {
            return
        }
        let calculationOptions = CalculationOptions(
            cameraPrice: cameraPrice ?? 0,
            cameraAmountValue: cameraAmountTextField.text,
            registratorAmountValue: registratorAmountTextField.text,
            cableLengthValue: cableLengthTextField.text
        )
        let calculation = calculationFabric?.makeCalculation(for: calculationOptions)
        
        calculationResultController.setup(calculation: calculation)
        if calculationResultController.isValidCalculation {
            calculationResultContainerView.isHidden = false
        }
    }
}
