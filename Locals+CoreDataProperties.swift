//
//  Locals+CoreDataProperties.swift
//  FinalProject_2014111535_ANY
//
//  Created by SWUCOMPUTER on 2017. 12. 23..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import Foundation
import CoreData


extension Locals {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Locals> {
        return NSFetchRequest<Locals>(entityName: "Locals")
    }

    @NSManaged public var localName: String?
    @NSManaged public var sortDate: NSDate?
    @NSManaged public var toLocalDetails: NSSet?

}

// MARK: Generated accessors for toLocalDetails
extension Locals {

    @objc(addToLocalDetailsObject:)
    @NSManaged public func addToToLocalDetails(_ value: LocalDetails)

    @objc(removeToLocalDetailsObject:)
    @NSManaged public func removeFromToLocalDetails(_ value: LocalDetails)

    @objc(addToLocalDetails:)
    @NSManaged public func addToToLocalDetails(_ values: NSSet)

    @objc(removeToLocalDetails:)
    @NSManaged public func removeFromToLocalDetails(_ values: NSSet)

}
