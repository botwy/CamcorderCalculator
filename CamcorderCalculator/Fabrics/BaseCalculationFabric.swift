//
//  BaseCalculationFabric.swift
//  CamcorderCalculator
//
//  Created by Гончаров Денис Васильевич on 03.08.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import Foundation

struct BaseCalculationFabric: CalculationFabric {
    func makeCalculation(for options: CalculationOptions?) -> Calculation? {
        return FirebaseCalculation(options: options)
    }
}
