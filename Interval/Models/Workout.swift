//
//  Workout.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-14.
//

import Foundation

class Workout: Identifiable, Codable {
    var id: UUID = UUID()
    var title: String = "Test title"
    var steps: [Step] = []
}

class Step: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var index: Int = 1
    var type: String = "distance"
    var target: Target = Target()
    var pace: String = "5.15 /km"
    
      // unsure if this is necessary now that it is a class
    static func ==(lhs: Step, rhs: Step) -> Bool {
        return lhs.index == rhs.index
    }
}

class Target: Codable {
    var magnitude: Int = 1
    var unit: String = "km"
}

@MainActor class Workouts: ObservableObject {
    @Published var allworkouts: [Workout]
    
    init() {
        self.allworkouts = []
    }
    
    func deleteWorkout(at offsets: IndexSet) {
        allworkouts.remove(atOffsets: offsets)
    }
    
    func addWorkout() {
        let newWorkout = Workout()
        allworkouts.append(newWorkout)
    }
    
    
}
