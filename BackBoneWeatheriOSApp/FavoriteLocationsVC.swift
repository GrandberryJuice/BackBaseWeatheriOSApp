//
//  FavoriteLocationsVC.swift
//  BackBoneWeatheriOSApp
//
//  Created by KENNETH GRANDBERRY on 8/29/17.
//  Copyright © 2017 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit
import CoreData

class FavoriteLocationsVC: UIViewController {
    
    //MARK: Properties
    @IBOutlet fileprivate var tableView:UITableView!
    var fetchResultsController:NSFetchedResultsController<FavoritePlaces>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        attempFetchRequest()
    }
    
    //MARK: Helper Functions
    func attempFetchRequest() {
        let fetchRequest:NSFetchRequest<FavoritePlaces> = FavoritePlaces.fetchRequest()
        let address = NSSortDescriptor(key: "address", ascending: false)
        fetchRequest.sortDescriptors = [address]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        fetchResultsController = controller
        
        do {
            try controller.performFetch()
        } catch {
            let error = error as NSError
            print("error:\(error)")
        }
    }
    
    func configureCell(cell:FavoritePlacesCell, indexPath:NSIndexPath) {
        let favoritePlace = fetchResultsController.object(at: indexPath as IndexPath)
        cell.configureCell(location: favoritePlace)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == favoriteLocationToMapVC {
            if let destiantion = segue.destination as? MapVC {
                destiantion.updateFavoritePlacesDelegate = self
            }
        }
    }
    
    //MARK: Actions
    @IBAction func goToMapVC(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: favoriteLocationToMapVC, sender: nil)
    }
    
    //MARK: Parse and save location Data
    func parseLocationData(location:Dictionary<String,AnyObject>) {
        let favoritePlacesContext = FavoritePlaces(context: context)
     
        if let streetAddress = location["Street"] as? String {
            favoritePlacesContext.street = streetAddress
        }
        
        if let zip = location["ZIP"] as? Int {
            favoritePlacesContext.zipcode = "\(zip)"
        }
        
        if let country = location["Country"] as? String {
            favoritePlacesContext.country = country
        }
        
        if let state = location["State"] as? String {
            favoritePlacesContext.state = state
        }
        
        if let city = location["City"] as? String {
            favoritePlacesContext.city = city
        }
        ad.saveContext()
        self.tableView.reloadData()
    }
}

extension FavoriteLocationsVC : UpdateFavoritePlacesDelegate {
    func updateDataFromMapViewController(locationData: Dictionary<String, AnyObject>) {
       parseLocationData(location: locationData)
    }
}

//MARK: UITableView Delegate and DataSource Functions
extension FavoriteLocationsVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: favoritePlaceReuseIdentifier) as? FavoritePlacesCell {
            configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            return cell
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = fetchResultsController.sections {
            let section = sections.count
            return section
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchResultsController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }
}

//MARK: FetchedResultsController Functions
extension FavoriteLocationsVC : NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch(type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case .update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! FavoritePlacesCell
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            break
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
        }
    }
}

