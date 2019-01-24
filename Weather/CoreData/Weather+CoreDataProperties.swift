//
//  Weather+CoreDataProperties.swift
//  
//
//  Created by Alexandra Gorshkova on 24/01/2019.
//
//

import Foundation
import CoreData


extension Weather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Weather> {
        return NSFetchRequest<Weather>(entityName: "Weather")
    }

    //@NSManaged public var startData: Int64
    //@NSManaged public var endData: Int64
    //@NSManaged public var temperature: Double
    @NSManaged public var name: String?
    //@NSManaged public var icon: String?

}
