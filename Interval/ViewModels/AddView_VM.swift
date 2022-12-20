//
//  AddView_VM.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-12-14.
//

import Foundation

extension AddView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published var newSteps = [NewStep]()
        @Published var newTitle = ""
        
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
    
}





