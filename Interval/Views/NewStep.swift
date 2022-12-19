//
//  NewStep.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-12-14.
//

import Foundation

struct NewStep: Identifiable {
    var id: UUID
    var index: Int16
    var type: String
    var magnitude: Int16
    var unit: String
    var pace: String
    var workout: Workout?
    
    static let example = NewStep(id: UUID(), index: 1, type: "distance", magnitude: 800, unit: "m", pace: "test pace")
}
