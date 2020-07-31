//
//  TestCalculation.swift
//  CamcorderCalculator
//
//  Created by Гончаров Денис Васильевич on 03.08.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import Foundation

final class FirebaseCalculation: Calculation {
    private var options: CalculationOptions
    
    init?(options: CalculationOptions?) {
        guard let options = options, FirebaseStore.shared.isSyncPricesSuccess else {
            return nil
        }
        self.options = options
    }
    
    var cameraSum: Int {
        options.cameraAmount * options.cameraPrice
    }
    
    var registratorSum: Int {
        options.registratorAmount * (FirebaseStore.shared.registratorPrice ?? 0)
    }
    
    var workSum: Int {
        options.cableLength * (FirebaseStore.shared.cablePrice ?? 0) + (FirebaseStore.shared.workPrice ?? 0)
    }
    
    var totalSum: Int {
        cameraSum + registratorSum + workSum
    }
}
