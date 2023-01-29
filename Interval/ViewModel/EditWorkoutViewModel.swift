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
    }
    
    func save() throws {
        try provider.persist(in: context)
    }
    
    // unsure if this should be in provider, vm, or object? leave here.
    func addStep(type: String) {
        let step = Step(context: context)
        step.id = UUID()
        step.type = type
        step.magnitude = 5
        
        if type == "distance" {
            step.unit = "km"
        } else if type == "time" {
            step.unit = "Minutes"
        }
        
        step.pace = 315
        step.index = Int16(workout.stepArray.count + 1)
        step.workout = workout
        objectWillChange.send() //updates list of steps
    }
    
    func deleteStep() {
        // delete step
    }
    
    
    
}
