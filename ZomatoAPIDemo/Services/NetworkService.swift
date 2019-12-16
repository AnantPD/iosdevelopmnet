//
//  NetworkService.swift
//  ZomatoAPIDemo
//
//  Created by Pavan P on 16/12/19.
//  Copyright © 2019 Anant. All rights reserved.
//

import UIKit

private let apiKey = "b34d2eac85ed778063ef08e821f9b028"

enum HTTPMethod: String {
    case get = "GET"
    case push = "PUSH"
}

enum ZomatoService {
    
    enum RestaurantProvider {
        
        case geocode(lat: Double, long: Double)
        
        var baseURL: URL {
            return URL(string: "https://developers.zomato.com/api/v2.1")!
        }

        var path: String {
            switch self {
            case .geocode:
                return "/geocode"
            }
        }

        var method: HTTPMethod {
            return .get
        }

        var parameters: [String: Any] {
            switch self {
            case let .geocode(lat, long):
                return ["lat": lat, "lon": long]
            }
        }

        var headers: [String : String]? {
            return ["Accept":"application/json", "user-key": apiKey]
        }
        
        func fetchRestaurants() {
            
        }
        
    }
}
