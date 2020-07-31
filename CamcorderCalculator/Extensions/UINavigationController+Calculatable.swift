//
//  UINavigationController+Calculatable.swift
//  CamcorderCalculator
//
//  Created by Гончаров Денис Васильевич on 05.08.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import UIKit

extension UINavigationController: Calculatable {
    var calculationFabric: CalculationFabric? {
        get {
            let controller = viewControllers.first as? Calculatable
            
            return controller?.calculationFabric
        }
        set {
            viewControllers.forEach{
                if let controller = $0 as? Calculatable {
                    controller.calculationFabric = newValue
                }
            }
        }
    }
    
    
}
