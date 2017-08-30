//
//  FavoritePlaces+CoreDataProperties.swift
//  BackBoneWeatheriOSApp
//
//  Created by KENNETH GRANDBERRY on 8/30/17.
//  Copyright © 2017 KENNETH GRANDBERRY. All rights reserved.
//

import Foundation
import CoreData


extension FavoritePlaces {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritePlaces> {
        return NSFetchRequest<FavoritePlaces>(entityName: "FavoritePlaces")
    }

    @NSManaged public var zipcode: String?
    @NSManaged public var state: String?
    @NSManaged public var country: String?
    @NSManaged public var street: String?
    @NSManaged public var city: String?
    @NSManaged public var address: String?
    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?

}
