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
    private let provider: WorkoutsProvider
    private let context: NSManagedObjectContext
    
    init(provider: WorkoutsProvider, workout: Workout? = nil) {
        self.provider = provider
        self.context = provider.newContext
        if let workout, // unwrap
           let existingWorkoutCopy = provider.exists(workout,
                                                     in: context) {  //does object exist in coreData?
            // if yes, load the object
            self.workout = existingWorkoutCopy
            self.isNew = false
        } else {
            // if no, create new workout
            self.workout = Workout(context: self.context)
            self.isNew = true
        }
        
        // self.workout.steps = self.workout.steps  // load steps
        //TODO: How can I add steps to this same context?
    }
    
    func save() throws {
        try provider.persist(in: context)
    }
    
    // placeholder for later
    func addStep(type: String) {
        //add step logic
    }
    
    
}
