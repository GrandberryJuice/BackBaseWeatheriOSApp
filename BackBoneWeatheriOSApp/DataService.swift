//
//  DataService.swift
//  BackBoneWeatheriOSApp
//
//  Created by KENNETH GRANDBERRY on 8/30/17.
//  Copyright © 2017 KENNETH GRANDBERRY. All rights reserved.
//

import Foundation

class DataService {
    
    //properties
    static let ds = DataService()
    fileprivate let weatherAPI:String = weatherURL
    typealias DownloadComplete = () -> ()
    var bookData = [WeatherForcast]()

    func getWeatherForcase() {
        guard let url = URL(string:weatherAPI) else {
            return print("Could not create url")
        }
        
        let session = URLSession.shared
    
    }
    
    
}
