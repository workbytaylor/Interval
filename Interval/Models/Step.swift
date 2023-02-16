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
    
    
    
    
    
    
    
    // sort filtered steps by index, ascending
    //static func sortedSteps() -> NSSortDescriptor {
        
    //}
}

// FOR PREVIEWS
extension Step {
    @discardableResult
    static func makePreview(count: Int, in context: NSManagedObjectContext) -> [Step] {
        var steps = [Step]()
        for i in 0..<count {
            let step = Step(context: context)
            step.id = UUID()
            step.index = Int16(count)
            step.magnitude = Int16(800+i)
            step.pace = 360
            step.type = "distance"
            step.unit = "m"
            steps.append(step)
        }
        return steps
    }
    
    static func preview(context: NSManagedObjectContext = WorkoutsProvider.shared.viewContext) -> Step {
        return makePreview(count: 1, in: context)[0]
    }
    
    static func empty(context: NSManagedObjectContext = WorkoutsProvider.shared.viewContext) -> Step {
        return Step(context: context)
    }
}



