//
//  Step+CoreDataProperties.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-01-04.
//
//

import Foundation
import CoreData


@objc(CoreDataStep)
public class CoreDataStep: NSManagedObject, Identifiable {

    @NSManaged public var id: UUID?
    @NSManaged public var type: String//?   // why is this needed?
    @NSManaged public var index: Int16
    @NSManaged public var length: Int16
    @NSManaged public var paceSeconds: Int16
    @NSManaged public var paceMinutes: Int16
    @NSManaged public var unit: String//?   // why is this needed?
    @NSManaged public var cdWorkout: CoreDataWorkout?
    @NSManaged public var hours: Int16  // added later
    @NSManaged public var minutes: Int16  // added later
    @NSManaged public var seconds: Int16  // added later
    
    
    /*  // why is this needed?
    public var wrappedType: String {
        type ?? "Unknown type"
    }
    
    public var wrappedUnit: String {
        unit ?? "Unknown unit"
    }
     */
}


