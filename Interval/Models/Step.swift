//
//  Step+CoreDataProperties.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-01-04.
//
//

import Foundation
import CoreData


@objc(Step)
public class Step: NSManagedObject, Identifiable {

    @NSManaged public var id: UUID?
    @NSManaged public var index: Int16
    @NSManaged public var magnitude: Int16
    @NSManaged public var pace: Int16
    @NSManaged public var type: String?
    @NSManaged public var unit: String?
    @NSManaged public var workout: Workout?
    
    public override func awakeFromInsert() {    // default values
        super.awakeFromInsert()
        setPrimitiveValue(UUID(), forKey: "id")
        setPrimitiveValue(5, forKey: "magnitude")
        setPrimitiveValue(315, forKey: "pace")
        setPrimitiveValue("distance", forKey: "type")
        setPrimitiveValue("meters", forKey: "unit")
    }
    
    public var wrappedType: String {
        type ?? "Unknown type"
    }
    
    public var wrappedUnit: String {
        unit ?? "Unknown unit"
    }
}


