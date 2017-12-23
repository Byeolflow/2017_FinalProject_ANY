//
//  LocalDetails+CoreDataProperties.swift
//  FinalProject_2014111535_ANY
//
//  Created by SWUCOMPUTER on 2017. 12. 23..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import Foundation
import CoreData


extension LocalDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalDetails> {
        return NSFetchRequest<LocalDetails>(entityName: "LocalDetails")
    }

    @NSManaged public var detailName: String?
    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?
    @NSManaged public var memo: String?
    @NSManaged public var saveDate: NSDate?
    @NSManaged public var toLocal: NSSet?

}

// MARK: Generated accessors for toLocal
extension LocalDetails {

    @objc(addToLocalObject:)
    @NSManaged public func addToToLocal(_ value: Locals)

    @objc(removeToLocalObject:)
    @NSManaged public func removeFromToLocal(_ value: Locals)

    @objc(addToLocal:)
    @NSManaged public func addToToLocal(_ values: NSSet)

    @objc(removeToLocal:)
    @NSManaged public func removeFromToLocal(_ values: NSSet)

}
