//
//  Workout+CoreDataProperties.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-01-04.
//
//

import Foundation
import CoreData


extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String//?  //making title optional prevents textfield from working
    @NSManaged public var steps: NSSet?
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        setPrimitiveValue(UUID(), forKey: "id")
    }
    
    // order steps based on index
    public var stepArray: [Step] {
        let set = steps as? Set<Step> ?? []
        
        return set.sorted {
            $0.index < $1.index
        }
    }
}

extension Workout {
    private static var workoutsFetchRequest: NSFetchRequest<Workout> {
        NSFetchRequest(entityName: "Workout")
    }
    
    static func all() -> NSFetchRequest<Workout> {
        let request: NSFetchRequest<Workout> = workoutsFetchRequest
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Workout.title, ascending: true)
        ]
        return request
    }
}


// MARK: Generated accessors for steps
extension Workout {

    @objc(addStepsObject:)
    @NSManaged public func addToSteps(_ value: Step)

    @objc(removeStepsObject:)
    @NSManaged public func removeFromSteps(_ value: Step)

    @objc(addSteps:)
    @NSManaged public func addToSteps(_ values: NSSet)

    @objc(removeSteps:)
    @NSManaged public func removeFromSteps(_ values: NSSet)

}

extension Workout {
    
    @discardableResult
    func makePreview(count: Int, in context: NSManagedObjectContext) -> [Workout] {
        var workouts = [Workout]()
        for i in 0..<count {
            let workout = Workout(context: context)
            workout.id = UUID()
            workout.title = "New workout \(i)"
            workouts.append(workout)
        }
        return workouts
    }
    
}
