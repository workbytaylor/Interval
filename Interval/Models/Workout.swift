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
}

struct Step: Identifiable {
    var id: UUID
    var index: Int  // 1, 2, 3
    var targetType: String    // time/duration
    var target: Target  // for ex: 800 meters
    var pace: String    // for ex: 5:15 minutes/km
}

struct Target {
    var magnitude: Int
    var unit: String
}
