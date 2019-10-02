//
//  Tag+CoreDataProperties.swift
//  
//
//  Created by Ankit on 24/02/19.
//
//

import Foundation
import CoreData


extension Tag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var title: String?
    @NSManaged public var strImagePath: String?

}
