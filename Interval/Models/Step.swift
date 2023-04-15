//
//  Step.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-03-28.
//
// a struct

//TODO: Make it a struct
import Foundation

struct Step: Identifiable {
    public let id: UUID = UUID()
    var type: String = "distance"
    
    // Time properties
    var hours: Int16 = 0
    var minutes: Int16 = 20
    var seconds: Int16 = 30
    
    // Distance properties
    // Should only have non-zero value if type == distance
    var length: Int16 = 0
    
    var unit: String = "kilometers"
    var pace: Int16 = 330   // seconds per km
    
    // Computed property for total time in seconds
    var totalSeconds: Int16 {
        hours*3600 + minutes*60 + seconds
    }
    
    // Computed property for pace minutes + seconds
    var paceMinutes: Int16 {
        pace/60
    }
    var paceSeconds: Int16 {
        pace%60
    }
    
    
    // changeUnit
    mutating func changeUnit() {
        switch type {
        case "distance":
            unit = "kilometers"
        case "time":
            unit = "minutes"
        default:
            unit = "Unknown unit"
        }
    }
    
}
