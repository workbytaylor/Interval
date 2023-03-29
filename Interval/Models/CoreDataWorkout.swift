//
//  Workout+CoreDataProperties.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-01-04.
//
//

import Foundation
import CoreData

@objc(CoreDataWorkout)
public class CoreDataWorkout: NSManagedObject, Identifiable {

    @NSManaged public var id: UUID?
    @NSManaged public var title: String //making title optional prevents textfield from working
    @NSManaged public var coreDataSteps: NSMutableSet?//NSSet?
    
    /*
    public override func awakeFromInsert() {    // adds default value for id property
        super.awakeFromInsert()
        setPrimitiveValue(UUID(), forKey: "id")
    }
     */
    
    public var stepArray: [CoreDataStep] {  // order steps based on index
        let setOfSteps = coreDataSteps as? Set<CoreDataStep> ?? []
        return setOfSteps.sorted {
            $0.index < $1.index
        }
    }
}

// FETCH REQUESTS
extension CoreDataWorkout {
    private static var workoutsFetchRequest: NSFetchRequest<CoreDataWorkout> {
        NSFetchRequest(entityName: "CoreDataWorkout")
    }
    
    static func all() -> NSFetchRequest<CoreDataWorkout> {  // fetch request for ContentView, sort by title ascending
        let request: NSFetchRequest<CoreDataWorkout> = workoutsFetchRequest
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \CoreDataWorkout.title, ascending: true)
        ]
        return request
    }
    
    static func filter(_ query: String) -> NSPredicate { // fetch request for ContentView, filter by search text
        query.isEmpty ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", query) // [cd] means any case (Upper/Lower)
    }
}
