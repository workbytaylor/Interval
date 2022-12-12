//
//  Workout+CoreDataProperties.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-12-11.
//
//

import Foundation
import CoreData


extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var steps: NSSet?
    
    public var wrappedTitle: String {
        title ?? "Unknown title"
    }
    
    // order steps based on index
    public var stepArray: [Step] {
        let set = steps as? Set<Step> ?? []
        
        return set.sorted {
            $0.index < $1.index
        }
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

extension Workout : Identifiable {

}
