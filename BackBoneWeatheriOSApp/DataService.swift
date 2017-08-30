//
//  DataService.swift
//  BackBoneWeatheriOSApp
//
//  Created by KENNETH GRANDBERRY on 8/30/17.
//  Copyright © 2017 KENNETH GRANDBERRY. All rights reserved.
//

//temperature, humidity, rain, chances and wind, information

import Foundation

class DataService {
    
    //properties
    static let ds = DataService()
    fileprivate let weatherAPI:String = weatherBase
    typealias DownloadComplete = () -> ()
    //var forcastData = Dictionary<String,AnyObject>()
    var forcastData = [[String:AnyObject]]()
    func getWeatherForcase(lat:String,lon:String,complete:@escaping DownloadComplete) {
        
        let weatherForcastString = "\(weatherBase)\(lat)&lon=\(lon)\(APIkey)"
        guard let url = URL(string:weatherForcastString) else {
            return print("Could not create url")
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            if let responseData = data {
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String,AnyObject> {
                        if let main = json["main"] as? Dictionary<String,AnyObject> {
                            if let temparatureHumidity = main["humidity"]  {
                               // self.forcastData.updateValue(temparatureHumidity, forKey: "humidity")
                                self.forcastData.append(["humidity":temparatureHumidity])
                            }
                        }
                        
                        if let weather = json["weather"] as? Array<AnyObject> {
                            for data in weather {
                                if let info = data as? Dictionary<String,AnyObject> {
                                    if let weatherType = info["main"] {
                                      //  self.forcastData.updateValue(weatherType, forKey: "weatherType")
                                        self.forcastData.append(["weatherType":weatherType])
                                    }
                                }
                            }
                        }
                        
                        if let wind = json["wind"] as? Dictionary<String,AnyObject>{
                            if let windspeed = wind["speed"] {
                               // self.forcastData.updateValue(windspeed, forKey: "windSpeed")
                                self.forcastData.append(["windspeed":windspeed])
                            }
                        }
                    }
                }catch {
                    print("could not seralize")
                }
            }
            complete()
        })
        task.resume()
    }
}
