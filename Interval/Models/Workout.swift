//
//  Workout.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-14.
//

import Foundation

class Workout: Identifiable, ObservableObject {
    let id: UUID = UUID()   // should this be 'var'?
    @Published var title: String = "Placeholder title"
    @Published var steps: [Step] = []
}

class Step: Identifiable, Equatable, ObservableObject {
    let id: UUID = UUID()   // should this be 'var'?
    @Published var index: Int = 1
    @Published var type: String = "distance"
    @Published var target: Target = Target()
    @Published var pace: String = "5.15 /km"
    
      // unsure if this is necessary now that it is a class
    static func ==(lhs: Step, rhs: Step) -> Bool {
        return lhs.index == rhs.index
    }
}

class Target: ObservableObject {
    @Published var magnitude: Int = 1
    @Published var unit: String = "km"
}

@MainActor class Workouts: ObservableObject {
    @Published var allworkouts: [Workout]
    
    init() {
        self.allworkouts = []
    }
    
    func deleteWorkout(at offsets: IndexSet) {
        allworkouts.remove(atOffsets: offsets)
    }
    
    /*
    func addWorkout(new: Workout) {
        allworkouts.append(new)
    }
    */
    
}
