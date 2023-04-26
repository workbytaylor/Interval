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
    var length: Int16 = 5
    var unit: String = "km" // only needed for distance now
    var pace: Int16 = 330   // seconds per km   // TODO: to be removed
    
    //Pace properties
    // TODO: refactor after computed properties changed
    var paceMinutes: Int16 = 5
    var paceSeconds: Int16 = 30
    
    // Computed property for total time in seconds
    var totalSeconds: Int16 {
        hours*3600 + minutes*60 + seconds
    }
    
    
}
