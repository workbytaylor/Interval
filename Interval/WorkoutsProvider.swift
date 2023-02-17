//
//  WorkoutsProvider.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-01-20.
//

import Foundation
import CoreData
import SwiftUI

final class WorkoutsProvider {
    
    static let shared = WorkoutsProvider()
    private let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    var newContext: NSManagedObjectContext {
        persistentContainer.newBackgroundContext()
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Interval")
        if EnvironmentValues.isPreview {
            persistentContainer.persistentStoreDescriptions.first?.url = .init(URL(fileURLWithPath: "/dev/null"))
        }
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        persistentContainer.loadPersistentStores { _, error in
            if let error {
                fatalError("Unable to load store with error: \(error)")
            }
        }
    }
    
    func workoutExists(_ workout: Workout,
                in context: NSManagedObjectContext) -> Workout? {
        try? context.existingObject(with: workout.objectID) as? Workout
    }
    
    func stepExists(_ step: Step,
                    in context: NSManagedObjectContext) -> Step? {
        try? context.existingObject(with: step.objectID) as? Step
    }
    
    func deleteWorkout(_ workout: Workout,
                in context: NSManagedObjectContext) throws {
        if let existingWorkout = workoutExists(workout, in: context) {
            context.delete(existingWorkout)
            Task(priority: .background) {
                try await context.perform {
                    try context.save()
                }
            }
        }
    }
    
    // delete a step, does not work yet
    /*
    func deleteStep(_ step: Step,
                 in context: NSManagedObjectContext) throws {
        if let existingStep = stepExists(step, in: context) {
            context.delete(existingStep)
        }
        Task(priority: .background) {
            try await context.perform {
                try context.save()
            }
        }
    }
     */
    
    
    func deleteStepWithOffsets(_ step: Step,
                               in context: NSManagedObjectContext) throws {
        if let existingStep = stepExists(step, in: context) {
            context.delete(existingStep)
        }
    }
    
    func renumberSteps() throws {
        
    }
    
    
    // add a new step
    func addStep(_ workout: Workout,
                    in context: NSManagedObjectContext,
                    type: String) throws {  // of? type
        if let existingWorkout = workoutExists(workout, in: context) {
            let step = Step(context: context)
            step.id = UUID()
            step.type = type
            step.magnitude = 5
            switch type {
            case "distance":
                step.unit = "kilometers"
            case "time":
                step.unit = "minutes"
            default:
                step.unit = "unknown step unit"
            }
            step.pace = 315
            step.index = Int16(existingWorkout.stepArray.count + 1)
            step.workout = existingWorkout
        }
    }
    
    func persist(in context: NSManagedObjectContext) throws {
        if context.hasChanges {
            try context.save()
        }
    }
    
}

extension EnvironmentValues {
    static var isPreview: Bool {
        return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}
