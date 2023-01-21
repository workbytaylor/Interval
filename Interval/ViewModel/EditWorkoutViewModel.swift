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
    }
    
    func save() throws {
        if context.hasChanges {
            try? context.save()
        }
    }
    
    
    
}
