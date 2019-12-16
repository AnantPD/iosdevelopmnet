//
//  Restaurant.swift
//  ZomatoAPIDemo
//
//  Created by Pavan P on 15/12/19.
//  Copyright © 2019 Anant. All rights reserved.
//

import Foundation
import CoreLocation

struct NearByRestaurants: Decodable {
    let nearby_restaurants: [RestaurantType]
}

struct RestaurantType: Decodable {
    let restaurant: RestaurantDetail
}

struct RestaurantDetail : Decodable {
    let id: String
    let name: String
    let thumb: String
    let featured_image: String
    let user_rating: Rating
    let location: Location
    let is_delivering_now: Int
    let price_range: Int
}

struct Rating: Decodable {
    let aggregate_rating: String
}

struct Location: Decodable {
    let address: String
    let latitude: String
    let longitude: String
    
    func getCoordinates() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(lat: latitude, lon: longitude)
    }
}

struct RestaurantViewModel {
    let id: String
    let name: String
    let thumb: URL?
    let featureImage: URL?
    let rating: String
    let location: Location
    let isOpen: Bool
    let price: String
    
    init(restaurant: RestaurantDetail) {
        self.id = restaurant.id
        self.name = restaurant.name
        self.thumb = URL(string: restaurant.thumb)
        self.featureImage = URL(string: restaurant.featured_image)
        self.rating = restaurant.user_rating.aggregate_rating
        self.location = restaurant.location
        self.isOpen = restaurant.is_delivering_now != 1
        self.price = String(repeating: "💲", count: restaurant.price_range)
    }
}

extension CLLocationCoordinate2D {
    init(lat: String, lon: String) {
        self.init()
        latitude = lat.toDouble() ?? 0.0
        longitude = lon.toDouble() ?? 0.0
    }
}

extension String {
    func toDouble() -> Double? {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 4
        return numberFormatter.number(from: self)?.doubleValue
    }
}
