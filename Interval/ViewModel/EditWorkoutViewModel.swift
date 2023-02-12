//
//  EditWorkoutViewModel.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-01-20.
//
/*
import Foundation
import CoreData
import SwiftUI

final class EditWorkoutViewModel: ObservableObject {
    
    @Published var workout: Workout
    let isNew: Bool
    private let provider: WorkoutsProvider
    private let context: NSManagedObjectContext
    /*
    init(provider: WorkoutsProvider, workout: Workout? = nil) {
        self.provider = provider
        self.context = provider.newContext
        if let workout, // is there a workout?
           let existingWorkoutCopy = provider.workoutExists(workout,
                                                            in: context) {  //does the workout exist in coreData?
            // if yes, load the object
            self.workout = existingWorkoutCopy
            self.isNew = false
            
            // TODO: try fetchrequest with CoreData
            
        } else {
            // if no, create new workout
            self.workout = Workout(context: self.context)
            self.isNew = true
        }
    }
    */
    func save() throws {
        try provider.persist(in: context)
    }
    
    func addStep(_ type: String) throws {
        try provider.addStep(workout, in: self.context, type: type)
        objectWillChange.send() // only needed if you want edits to be temporary
        //try save()  // add save here if you want to remove the cancel button, delete objectwillchange.send() above
    }
    
    func deleteStepWithOffsets(_ offsets: IndexSet) {
        for i in offsets {
            let step = workout.stepArray[i]
            
            do {
                try provider.deleteStepWithOffsets(step, in: self.context)
                //try save()
                //objectWillChange.send()   // uncommenting this does not work
                // TODO: Issue lies in stepArray not updating when step deleted
            } catch {
                print(error)
            }
        }
    }
    
    
    // TODO: Move to provider
    func renumberSteps(_ offsets: IndexSet) {
        for i in offsets {
            let stepIndex = Int(workout.stepArray[i].index)
            if stepIndex < workout.stepArray.count {
                let renumRange = stepIndex..<workout.stepArray.count
                for num in renumRange {
                    var count = num
                    let step = workout.stepArray[num]
                    step.index = Int16(count)
                    count += 1
                }
            }
        }
        objectWillChange.send()
    }
    
    
}
*/
