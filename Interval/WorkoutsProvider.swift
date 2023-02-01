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
    
    func exists(_ workout: Workout,
                in context: NSManagedObjectContext) -> Workout? {
        try? context.existingObject(with: workout.objectID) as? Workout
    }
    
    func deleteWorkout(_ workout: Workout,
                in context: NSManagedObjectContext) throws {
        if let existingWorkout = exists(workout, in: context) {
            context.delete(existingWorkout)
            Task(priority: .background) {
                try await context.perform {
                    try context.save()
                }
            }
        }
    }
    
    func deleteStep(_ step: Step,
                in context: NSManagedObjectContext) throws {
        
    }
    
    func eraseTitle() throws {
        
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
