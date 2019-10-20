//
//  Places+CoreDataProperties.swift
//  My Favorite Places
//
//  Created by Olha Skulska on 2019. 10. 20..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//
//

import Foundation
import CoreData


extension Places {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Places> {
        return NSFetchRequest<Places>(entityName: "Entity")
    }

    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var location: String?
    @NSManaged public var isVisited: Bool
    @NSManaged public var img: Data?

}
