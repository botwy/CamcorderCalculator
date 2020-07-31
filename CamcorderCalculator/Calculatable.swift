//
//  Calculatable.swift
//  CamcorderCalculator
//
//  Created by Гончаров Денис Васильевич on 04.08.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import Foundation

protocol Calculatable: AnyObject {
    var calculationFabric: CalculationFabric? { get set }
}
