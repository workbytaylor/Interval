//
//  Step+CoreDataProperties.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-12-11.
//
//

import Foundation
import CoreData


extension Step {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Step> {
        return NSFetchRequest<Step>(entityName: "Step")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var index: Int16
    @NSManaged public var magnitude: Int16
    @NSManaged public var pace: String?
    @NSManaged public var type: String?
    @NSManaged public var unit: String?
    @NSManaged public var workout: Workout?
    
    //may need wrappedID - unsure
    
    public var wrappedPace: String {
        pace ?? "Unknown pace"
    }
    
    public var wrappedType: String {
        type ?? "Unknown type"
    }
    
    public var wrappedUnit: String {
        unit ?? "Unknown unit"
    }

}

extension Step : Identifiable {

}
