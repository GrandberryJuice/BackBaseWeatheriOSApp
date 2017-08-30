//
//  weatherCell.swift
//  BackBoneWeatheriOSApp
//
//  Created by KENNETH GRANDBERRY on 8/30/17.
//  Copyright © 2017 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit

class weatherCell: UITableViewCell {

    @IBOutlet fileprivate var weatherinfo:UILabel!
    @IBOutlet fileprivate var weatherHumidity:UILabel!
    @IBOutlet fileprivate var weatherType:UILabel!
    @IBOutlet fileprivate var temp:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configureCell(data:WeatherForcast) {
        weatherinfo.text = data.wind
        weatherHumidity.text = data.humidity
        weatherType.text = data.rainPercentage
        temp.text = data.temperature
    }
    
}
