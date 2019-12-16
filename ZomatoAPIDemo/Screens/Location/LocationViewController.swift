//
//  LocationViewController.swift
//  ZomatoAPIDemo
//
//  Created by Pavan P on 15/12/19.
//  Copyright © 2019 Anant. All rights reserved.
//

import UIKit

protocol LocationActions: class {
    func didTapAllow()
}

class LocationViewController: UIViewController {

    @IBOutlet weak var locationView: LocationView!
    weak var delegate: LocationActions?

    override func viewDidLoad() {
        super.viewDidLoad()

        locationView.didTapAllow = {
            self.delegate?.didTapAllow()
        }
    }
    

}
