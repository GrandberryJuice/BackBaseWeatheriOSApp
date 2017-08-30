//
//  FavoritePlacesCell.swift
//  BackBoneWeatheriOSApp
//
//  Created by KENNETH GRANDBERRY on 8/30/17.
//  Copyright © 2017 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit

class FavoritePlacesCell: UITableViewCell  {
    
    @IBOutlet fileprivate var address:UILabel!
    @IBOutlet fileprivate var state:UILabel!
    @IBOutlet fileprivate var city:UILabel!
    
    override func awakeFromNib() {
    }
    
    func configureCell(location:FavoritePlaces) {
        address.text = location.street
        state.text = location.state
        city.text = location.city
    }
}
