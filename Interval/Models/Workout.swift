//
//  Workout+CoreDataProperties.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-01-04.
//
//

import Foundation
import CoreData

@objc(Workout)
public class Workout: NSManagedObject, Identifiable {

    @NSManaged public var id: UUID?
    @NSManaged public var title: String //making title optional prevents textfield from working
    @NSManaged public var steps: NSMutableSet?//NSSet?
    
    /*
    public override func awakeFromInsert() {    // adds default value for id property
        super.awakeFromInsert()
        setPrimitiveValue(UUID(), forKey: "id")
    }
     */
    
    public var stepArray: [Step] {  // order steps based on index
        let setOfSteps = steps as? Set<Step> ?? []
        return setOfSteps.sorted {
            $0.index < $1.index
        }
    }
}

// FETCH REQUESTS
extension Workout {
    private static var workoutsFetchRequest: NSFetchRequest<Workout> {
        NSFetchRequest(entityName: "Workout")
    }
    
    static func all() -> NSFetchRequest<Workout> {  // fetch request for ContentView, sort by title ascending
        let request: NSFetchRequest<Workout> = workoutsFetchRequest
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Workout.title, ascending: true)
        ]
        return request
    }
    
    static func filter(_ query: String) -> NSPredicate { // fetch request for ContentView, filter by search text
        query.isEmpty ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", query) // [cd] means any case (Upper/Lower)
    }
}
