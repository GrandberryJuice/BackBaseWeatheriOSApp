//
//  MapVC.swift
//  BackBoneWeatheriOSApp
//
//  Created by KENNETH GRANDBERRY on 8/29/17.
//  Copyright © 2017 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit
import MapKit

protocol UpdateFavoritePlacesDelegate {
    func updateDataFromMapViewController(locationData:Dictionary<String , AnyObject>)
}

class MapVC: UIViewController {
    
    //MARK: properties
    @IBOutlet fileprivate var mapView:MKMapView!
    let locationManager = CLLocationManager()
    fileprivate var mapHasCenterdOnce = false
    var updateFavoritePlacesDelegate:UpdateFavoritePlacesDelegate?
    
    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationStatus()
    }
    
    //MARK: Map Helper Functions
    func locationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func centerMaponLocation(location:CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2000, 2000)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    
    func displayLocationInfo(placemark: CLPlacemark) {
        locationManager.stopUpdatingLocation()
        if let address = placemark.addressDictionary as? Dictionary<String,AnyObject> {
            updateFavoritePlacesDelegate?.updateDataFromMapViewController(locationData: address)
        }
    }
    
    func addPinToMap(location:CLLocation) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        mapView.addAnnotation(annotation)
    }
    
    //MARK: Actions
    @IBAction func AddlocationBtn(_ sender: UIButton) {
        let title = "Your favorite location was added"
        let msg = "Your favorite location was added and saved"
        let loc = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude:mapView.centerCoordinate.longitude)
        CLGeocoder().reverseGeocodeLocation(loc,completionHandler: { placemarks, error in
            if (error != nil) {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            if let placemarks = placemarks {
                if placemarks.count > 0 {
                    let pm = placemarks[0] as CLPlacemark
                    self.displayLocationInfo(placemark: pm)
                }
            }
        })
        addPinToMap(location: loc)
        alertPopUp(_title: title, msg: msg)
    }
    
    func alertPopUp(_title:String, msg:String) {
        let alert = UIAlertController(title:title, message: msg, preferredStyle:.alert)
        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated:true, completion:nil)
    }
}

//MARK: Map Delegate Functions
extension MapVC: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if let loc = userLocation.location {
            if !mapHasCenterdOnce {
                centerMaponLocation(location: loc)
                mapHasCenterdOnce = true
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView:MKAnnotationView?
        
        if annotation.isKind(of: MKUserLocation.self) {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "User")
            annotationView?.image = UIImage(named: "placeholder")
        }
        return annotationView
    }
}

//MARK: Location Delegate Functions
extension MapVC : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        }
    }
}
