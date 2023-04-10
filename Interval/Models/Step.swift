//
//  Step.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-03-28.
//

import Foundation

public class Step: ObservableObject, Identifiable {
    public let id: UUID = UUID()
    @Published var type: String = "time"
    
    // time properties
    @Published var hours: Int16 = 0
    @Published var minutes: Int16 = 20
    @Published var seconds: Int16 = 30
    
    // distance properties
    // should only have non-zero value if type == distance
    @Published var length: Int16 = 0
    
    @Published var unit: String = "minutes"
    @Published var pace: Int16 = 330   // seconds per km
    
    // computed property for total time in seconds, used when running in progress
    var totalSeconds: Int16 {
        hours*3600 + minutes*60 + seconds
    }
    
    // computer property for pace minutes + seconds
    var paceMinutes: Int16 {
        pace/60
    }
    var paceSeconds: Int16 {
        pace%60
    }
    
    /*
    // no longer needed
    func hours() -> Int16 {
    return magnitude/3600
    }
    func minutes() -> Int16 {
    return (magnitude%3600)/60
    }
    func seconds() -> Int16 {
    return (magnitude%3600)%60
    }
    
    
    var hours: Int16 {
        magnitude/3600
    }
    var minutes: Int16 {
        magnitude%3600/60
    }
    var seconds: Int16 {
        magnitude%3600%60
    }
    */
    
    
}
