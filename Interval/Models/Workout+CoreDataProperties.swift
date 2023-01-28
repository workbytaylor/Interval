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
    
    var isValid: Bool {
        !title.isEmpty
    }
    
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        setPrimitiveValue(UUID(), forKey: "id")
    }
    
    // order steps based on index
    public var stepArray: [Step] {
        let setOfSteps = steps as? Set<Step> ?? []
        return setOfSteps.sorted {
            $0.index < $1.index
        }
    }
}

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

extension Workout { // provides preview to use with CoreData
    
    @discardableResult
    static func makePreview(count: Int, in context: NSManagedObjectContext) -> [Workout] {
        var workouts = [Workout]()
        for i in 0..<count {
            let workout = Workout(context: context)
            workout.id = UUID()
            workout.title = "New workout \(i)"
            workouts.append(workout)
        }
        return workouts
    }
    
    static func preview(context: NSManagedObjectContext = WorkoutsProvider.shared.viewContext) -> Workout {
        return makePreview(count: 1, in: context)[0]
    }
    
    static func empty(context: NSManagedObjectContext = WorkoutsProvider.shared.viewContext) -> Workout {
        return Workout(context: context)
    }
    
    
}
