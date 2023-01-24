//
//  EditWorkoutViewModel.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-01-20.
//

import Foundation
import CoreData

final class EditWorkoutViewModel: ObservableObject {
    
    @Published var workout: Workout
    let isNew: Bool
    private let context: NSManagedObjectContext
    
    init(provider: WorkoutsProvider, workout: Workout? = nil) {
        self.context = provider.newContext
        if let workout, // unwrap
           let existingWorkoutCopy = try? context.existingObject(with: workout.objectID) as? Workout {  //does object existing in coreData?
            // if yes, load the object
            self.workout = existingWorkoutCopy
            self.isNew = false
        } else {
            self.workout = Workout(context: self.context)
            self.isNew = true
        }
        
        // self.workout.steps = self.workout.steps  // load steps
        //TODO: How can I add steps to this same context?
    }
    
    func save() throws {
        if context.hasChanges {
            try? context.save()
        }
    }
    
    // placeholder for later
    func addDistanceStep() {
        //add distance step
    }
    
    
}
