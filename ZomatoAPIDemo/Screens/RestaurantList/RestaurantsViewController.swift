//
//  RestaurantsViewController.swift
//  ZomatoAPIDemo
//
//  Created by Pavan P on 15/12/19.
//  Copyright © 2019 Anant. All rights reserved.
//

import UIKit
import CoreLocation

class RestaurantsViewController: UITableViewController {
    let locationService = LocationService()
    var locationViewController: LocationViewController!
    var restaurants = [RestaurantViewModel]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        locationService.didChangeStatus = { [weak self] success in
            if success {
                self?.locationService.getLocation()
            }
        }

        locationService.newLocation = { [weak self] result in
            switch result {
            case .success(let location):
                if self?.locationViewController != nil {
                    self?.locationViewController.dismiss(animated: true, completion: nil)
                }
                self?.didLocationUpdate(coordinate: location.coordinate)
            case .failure(let error):
                assertionFailure("Error getting the users location \(error)")
            }
        }

        switch locationService.status {
        case .notDetermined, .denied, .restricted:
            locationViewController = storyboard?.instantiateViewController(withIdentifier: "LocationViewController") as? LocationViewController
            locationViewController.delegate = self
            present(locationViewController, animated: true, completion: nil)
        default:
            locationService.getLocation()
        }

    }
        
    func didLocationUpdate(coordinate: CLLocationCoordinate2D?) {
        
        if let location = coordinate {
//            let coordinatesDict = ["lat": location.latitude, "lon": location.longitude]
            fetchRestaurantsNearby(location: location)
        }
    }
    
    func fetchRestaurantsNearby(location: CLLocationCoordinate2D) {
        let url1 = "https://developers.zomato.com/api/v2.1/geocode?lat=\(location.latitude)&lon=\(location.longitude)"
        let api = "b34d2eac85ed778063ef08e821f9b028"
        
        let url = URL(string: url1)!
        var request = URLRequest(url: url)
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(api, forHTTPHeaderField: "user-key")
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { [weak self] (data, response, _) in
            do {
                guard let list = data else { return }
                let jsonDecoder = JSONDecoder()
                let fetch = try jsonDecoder.decode(NearByRestaurants.self, from:list)
                print(fetch)
                
                self?.restaurants = fetch.nearby_restaurants.compactMap { RestaurantViewModel.init(restaurant: $0.restaurant) }
            }
            catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
}

extension RestaurantsViewController {
    
    //MARK:- Tableview Data Source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantTableViewCell

        let restaurant = restaurants[indexPath.row]
        cell.configureCell(withModel: restaurant)
        return cell
    }
    
    //MARK:- Tableview Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailsViewController = storyboard?.instantiateViewController(withIdentifier: "RestaurantDetailsController") as? RestaurantDetailsController else { return }
        detailsViewController.viewModel = restaurants[indexPath.row]
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

//MARK:- Location Actions Delegate

extension RestaurantsViewController: LocationActions {
    
    func didTapAllow() {
        locationService.requestLocationAuthorization()
    }
    
}


