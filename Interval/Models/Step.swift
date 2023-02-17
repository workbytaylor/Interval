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
    }
    
    public var wrappedType: String {
        type ?? "Unknown type"
    }
    
    public var wrappedUnit: String {
        unit ?? "Unknown unit"
    }
}

// FETCH REQUESTS
extension Step {
    private static var stepsFetchRequest: NSFetchRequest<Step> {
        NSFetchRequest(entityName: "Step")
    }
    
    // sorted by index
    static func filtered(filterKey: Workout, filterValue: String) -> NSFetchRequest<Step> {
        let request: NSFetchRequest<Step> = stepsFetchRequest
        //sort steps by index
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Step.index, ascending: true)
        ]
        // filter steps by workout
        request.predicate = NSPredicate(format: "%K = %@", filterKey, filterValue)
        
        
        
        return request
    }
    
    /*
     static func all() -> NSFetchRequest<Workout> {  // fetch request for ContentView, sort by title ascending
         let request: NSFetchRequest<Workout> = workoutsFetchRequest
         request.sortDescriptors = [
             NSSortDescriptor(keyPath: \Workout.title, ascending: true)
         ]
         return request
     }
     */
    
    // filter for steps that relate to selected workout
    static func filtered(of workout: Workout) -> NSPredicate {
        NSPredicate(format: "workout = %@", workout)
    }
    
}




