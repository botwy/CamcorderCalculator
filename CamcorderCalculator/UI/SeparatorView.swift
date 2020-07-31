//
//  SeparatorView.swift
//  Authentication
//
//  Created by Kamil Manafov on 13/06/2019.
//  Copyright © 2019 Andrey Ilskiy. All rights reserved.
//

import UIKit

final class SeparatorView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setup() {
        backgroundColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
    }
}
