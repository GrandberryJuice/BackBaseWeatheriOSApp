//
//  ForcastVC.swift
//  BackBoneWeatheriOSApp
//
//  Created by KENNETH GRANDBERRY on 8/30/17.
//  Copyright © 2017 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit
import MapKit

class ForcastVC: UIViewController {
    
    //properties
    var countryInfo:String?
    var zipCode:String?
    var favoritePlaces:FavoritePlaces?
    var weatherForcast = [WeatherForcast]()
    @IBOutlet fileprivate var tableView:UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        guard let lat = favoritePlaces?.latitude, let lon = favoritePlaces?.longitude else {
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            DataService.ds.getWeatherForcase(lat: lat, lon: lon) {
                DispatchQueue.main.async {
                 let data = DataService.ds.forcastData
                    for info in data {
                        let weatherInfo = WeatherForcast(data: info)
                        self.weatherForcast.append(weatherInfo)
                    }
                }
            }
            self.tableView.reloadData()
        }
    }
}

extension ForcastVC:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = weatherForcast[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell") as? weatherCell {
            cell.configureCell(data: data)
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherForcast.count
    }
    
}
