//
//  TestCalculation.swift
//  CamcorderCalculator
//
//  Created by Гончаров Денис Васильевич on 03.08.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import Foundation

final class TestCalculation: Calculation {
    private var options: CalculationOptions
    
    init?(options: CalculationOptions?) {
        guard let options = options else {
            return nil
        }
        self.options = options
    }
    
    var cameraSum: Int {
        options.cameraAmount * options.cameraPrice
    }
    
    var registratorSum: Int {
        options.registratorAmount * 1000
    }
    
    var workSum: Int {
        options.cableLength * 100 + 5000
    }
    
    var totalSum: Int {
        cameraSum + registratorSum + workSum
    }
    
    
}
