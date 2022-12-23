//
//  DetailView_VM.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-12-21.
//

import Foundation

extension DetailView {
    
    func deleteWorkout() {
        moc.delete(workout)
        save()
        dismiss()   //returns to ContentView after delete
    }
    
    func deleteStep(at offsets: IndexSet) {
        for index in offsets {
            let step = workout.stepArray[index]
            moc.delete(step)
            renumberSteps(step: step)
            save()
        }
    }
    
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
    
    func save() {
        if moc.hasChanges {
            try? moc.save()
        }
    }
    
    
    
    
}
