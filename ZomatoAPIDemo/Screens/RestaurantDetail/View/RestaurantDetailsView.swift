//
//  RestaurantDetailsView.swift
//  ZomatoAPIDemo
//
//  Created by Pavan P on 16/12/19.
//  Copyright © 2019 Anant. All rights reserved.
//

import UIKit
import MapKit

@IBDesignable class RestaurantDetailsView: UIView {

    @IBOutlet weak var featureImgView: UIImageView?
    @IBOutlet weak var priceLabel: UILabel?
    @IBOutlet weak var hoursLabel: UILabel?
    @IBOutlet weak var locationLabel: UILabel?
    @IBOutlet weak var ratingsLabel: UILabel?
    @IBOutlet weak var mapView: MKMapView?

}
