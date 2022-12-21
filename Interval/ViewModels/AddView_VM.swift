//
//  AddView_VM.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-12-14.
//

import Foundation

extension AddView {
    
    // Functions that act on AddView's data go here
    @MainActor class ViewModel: ObservableObject {
        
        @Published var newSteps = [NewStep]()
        @Published var newTitle = ""
        //@Published var newDescription = ""    // TODO: Add description to workout at later date, also add in CoreData
        
        func addTimeStep() {
            let timeStep = NewStep(id: UUID(), index: Int16(newSteps.count+1), type: "time", magnitude: 10, unit: "minutes", pace: "timePace")
            newSteps.append(timeStep)
        }
        
        func addDistanceStep() {
            let distanceStep = NewStep(id: UUID(), index: Int16(newSteps.count+1), type: "distance", magnitude: 5, unit: "km", pace: "distancePace")
            newSteps.append(distanceStep)
        }
        
        func move(from source: IndexSet, to destination: Int) {
            newSteps.move(fromOffsets: source, toOffset: destination)
        }
    }
    
    // Functions that act on CoreData go here
    func createWorkout() {
        let newWorkout = Workout(context: moc)
        newWorkout.id = UUID()
        newWorkout.title = vm.newTitle
        createSteps(newWorkout)
        save()
        dismiss()
    }
    
    func createSteps(_ newWorkout: Workout) {
        var i = 1
        for newStep in vm.newSteps {
            let step = Step(context: moc)
            step.id = newStep.id
            step.type = newStep.type
            step.magnitude = newStep.magnitude
            step.unit = newStep.unit
            step.pace = newStep.pace
            step.index = Int16(i)
            step.workout = newWorkout
            i+=1
        }
    }
    
    func save() {
        if moc.hasChanges {
            try? moc.save()
        }
    }
    
    
}





