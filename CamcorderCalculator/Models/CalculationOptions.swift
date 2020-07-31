//
//  CalculatorOptions.swift
//  CamcorderCalculator
//
//  Created by Гончаров Денис Васильевич on 03.08.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import Foundation

struct CalculationOptions {
    let cameraPrice: Int
    let cameraAmount: Int
    let registratorAmount: Int
    let cableLength: Int
    
    init(cameraPrice: Int, cameraAmount: Int, registratorAmount: Int, cableLength: Int) {
                self.cameraPrice = cameraPrice
                self.cameraAmount = cameraAmount
                self.registratorAmount = registratorAmount
                self.cableLength = cableLength
    }
    
    init?(cameraPrice: Int?, cameraAmountValue: String?, registratorAmountValue: String?, cableLengthValue: String?) {
        guard let cameraPrice = cameraPrice,
            let cameraAmountValue = cameraAmountValue, let cameraAmount = Int(cameraAmountValue),
            let registratorAmountValue = registratorAmountValue, let registratorAmount = Int(registratorAmountValue),
            let cableLengthValue = cableLengthValue, let cableLength = Int(cableLengthValue) else {
            return nil
        }
        
        self.init(cameraPrice: cameraPrice, cameraAmount: cameraAmount, registratorAmount: registratorAmount, cableLength: cableLength)
     }
}
