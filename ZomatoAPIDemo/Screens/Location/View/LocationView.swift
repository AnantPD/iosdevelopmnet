//
//  LocationView.swift
//  ZomatoAPIDemo
//
//  Created by Pavan P on 15/12/19.
//  Copyright © 2019 Anant. All rights reserved.
//

import UIKit

@IBDesignable class LocationView: UIView {
    
    @IBOutlet weak var allowButton: UIButton!
    @IBOutlet weak var denyButton: UIButton!

    var didTapAllow: (() -> Void)?

    @IBAction func allowAction(_ sender: UIButton) {
        didTapAllow?()
    }

    @IBAction func denyAction(_ sender: UIButton) {

    }
    
}
