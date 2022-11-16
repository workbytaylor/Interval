//
//  Workout.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-14.
//

import Foundation

struct Workout: Identifiable {
    var id: UUID
    var title: String
    var steps: [Step]
    
    static let example = Workout(id: UUID(), title: "Test title", steps: [Step.example])
}

// Many steps in each workout
struct Step: Identifiable {
    var id: UUID
    var index: Int  // 1, 2, 3
    var targetType: String    // time/distance for each step
    var target: Target  // for ex: 800 meters
    var pace: String    // for ex: 5:15 minutes/km OR 5*60+15 = 315 seconds per km
    
    static let example = Step(id: UUID(), index: 1, targetType: "distance", target: Target.example, pace: "5:15 /km")
}

// time/duration for each step
struct Target {
    var magnitude: Int  // for ex. '800'
    var unit: String    // for ex. 'm' for meters
    
    static let example = Target(magnitude: 800, unit: "m")
}
