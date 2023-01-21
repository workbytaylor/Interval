//
//  DetailView_Ext.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-12-21.
//

import Foundation

extension DetailView {
    /*
    // Keep
    func deleteWorkout() {
        moc.delete(workout)
        save()
        dismiss()   //returns to ContentView after delete
    }
    
    // TODO: DELETE
    func deleteStep(at offsets: IndexSet) {
        for index in offsets {
            let step = workout.stepArray[index]
            moc.delete(step)
            renumberSteps(step: step)
            save()
        }
    }
    
    // TODO: DELETE
    func renumberSteps(step: Step) {
        let stepIndexToDelete = Int(step.index)
        if stepIndexToDelete < workout.stepArray.count {
            let start = stepIndexToDelete
            let range = start..<workout.stepArray.count
            for num in range {
                var count = num
                let step = workout.stepArray[num]
                step.index = Int16(count)
                count += 1
            }
        }
    }
    
    func addTimeStep() {
        let timeStep = Step(context: moc)
        timeStep.id = UUID()
        timeStep.index = Int16(workout.stepArray.count + 1)
        timeStep.type = "time"
        timeStep.magnitude = Int16(10)
        timeStep.unit = "minutes"
        timeStep.pace = 315
        timeStep.workout = workout
        save()
    }
    
    func addDistanceStep() {
        let timeStep = Step(context: moc)
        timeStep.id = UUID()
        timeStep.index = Int16(workout.stepArray.count + 1)
        timeStep.type = "distance"
        timeStep.magnitude = Int16(5)
        timeStep.unit = "km"
        timeStep.pace = 315
        timeStep.workout = workout
        save()
    }
    
    */
}
