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
    
    private let context: NSManagedObjectContext
    
    init(provider: WorkoutsProvider, workout: Workout? = nil) {
        self.context = provider.newContext
        self.workout = Workout(context: self.context)
        self.workout.steps = self.workout.steps
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
