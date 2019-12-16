//
//  RestaurantDetailsController.swift
//  ZomatoAPIDemo
//
//  Created by Pavan P on 16/12/19.
//  Copyright © 2019 Anant. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class RestaurantDetailsController: UIViewController {
    
    @IBOutlet weak var detailsView: RestaurantDetailsView!
    var viewModel: RestaurantViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    func updateView() {
        if let viewModel = viewModel {
            if let featureImgURL = viewModel.featureImage {
                detailsView.featureImgView?.af_setImage(withURL: featureImgURL)
            } else if let imageURL = viewModel.thumb {
                detailsView.featureImgView?.af_setImage(withURL: imageURL)
            }
            detailsView.priceLabel?.text = viewModel.price
            detailsView.hoursLabel?.text = viewModel.isOpen ? "Open" : "Close"
            detailsView.locationLabel?.text = viewModel.location.address
            detailsView.ratingsLabel?.text = viewModel.rating
            centerMap(for: viewModel.location.getCoordinates())
            title = viewModel.name
        }
    }
    
    func centerMap(for coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        detailsView.mapView?.addAnnotation(annotation)
        detailsView.mapView?.setRegion(region, animated: true)
    }
}
