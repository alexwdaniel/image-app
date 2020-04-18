//
//  Photo+CoreDataProperties.swift
//  ImageApp
//
//  Created by Alexander Daniel on 4/5/20.
//  Copyright © 2020 adaniel. All rights reserved.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var date: Date?
    @NSManaged public var name: String?

}
