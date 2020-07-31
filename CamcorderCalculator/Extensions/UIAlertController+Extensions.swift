//
//  UIAlertController+Extensions.swift
//  CamcorderCalculator
//
//  Created by Гончаров Денис Васильевич on 27.09.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import UIKit

extension UIAlertController {
    convenience init(with error: Error) {
        self.init(title: "", message: error.localizedDescription, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Закрыть", style: .cancel) {[weak self] _ in
            self?.dismiss(animated: true)
        }
        addAction(closeAction)
    }
}
