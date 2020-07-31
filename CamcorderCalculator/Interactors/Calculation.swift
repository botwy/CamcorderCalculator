//
//  Calculation.swift
//  CamcorderCalculator
//
//  Created by Гончаров Денис Васильевич on 03.08.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import Foundation

protocol Calculation {
    var cameraSum: Int { get }
    var registratorSum: Int { get }
    var workSum: Int { get }
    var totalSum: Int { get }
}
