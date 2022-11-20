//
//  AddView-ViewModel.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-18.
//

import Foundation

extension AddView { // TODO: change viewmodels from extensions to ? Need to share data between viewmodels, or across app
    @MainActor class AddView_ViewModel: ObservableObject {
        @Published var newWorkout: Workout?
        @Published var newTitle: String
        @Published var newSteps: [Step]
        
        init() {    // is the initializer really necessary? think yes - at least for structs
            newWorkout = nil
            newTitle = ""
            newSteps = []
        }
        
        func addDistanceStep() {
            let newStep = Step(
                id: UUID(),
                index: newSteps.count+1,
                type: "distance",   // make enum
                target: Target(magnitude: 1, unit: "km"),
                pace: "5:15 m/km"
            )
            newSteps.append(newStep)
        }
        
        func addTimeStep() {
            let newStep = Step (
                id: UUID(),
                index: newSteps.count+1,
                type: "time",   // make enum
                target: Target(magnitude: 10, unit: "minutes"),
                pace: "5:15 m/km"
            )
            newSteps.append(newStep)
        }
        
        func deleteNewStep(at offsets: IndexSet) {
            newSteps.remove(atOffsets: offsets)
            //TODO: renumber index at all steps that come after the deleted step
        }
        
        func createWorkout() {
            // how to pass data between viewmodels?
        }
        
        
    }
}


