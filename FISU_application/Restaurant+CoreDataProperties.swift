//
//  Restaurant+CoreDataProperties.swift
//  FISU_application
//
//  Created by LoïcDumas on 24/03/2016.
//  Copyright © 2016 Arnaud ZARAGOZA. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData


extension Restaurant {
    
    @NSManaged var descriptionRestaurant: String?
    @NSManaged var name: String?
    @NSManaged var rate: NSNumber?
    @NSManaged var openning: NSNumber?
    @NSManaged var closing: NSNumber?
    @NSManaged var location: Place?
    
}

