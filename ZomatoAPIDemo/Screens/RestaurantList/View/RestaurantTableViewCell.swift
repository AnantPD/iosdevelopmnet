//
//  RestaurantTableViewCell.swift
//  ZomatoAPIDemo
//
//  Created by Pavan P on 15/12/19.
//  Copyright © 2019 Anant. All rights reserved.
//

import UIKit
import AlamofireImage

class RestaurantTableViewCell: UITableViewCell {
    @IBOutlet weak var restaurantImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(withModel restaurant: RestaurantViewModel) {
        if let imageURL = restaurant.thumb {
            restaurantImg.af_setImage(withURL: imageURL)
        }
        nameLbl.text = restaurant.name
        distanceLbl.text = restaurant.rating
    }

}
