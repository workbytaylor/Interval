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
    @Published var magnitude: Int16 = 305   // default time unit is seconds
    @Published var unit: String = "minutes"
    @Published var pace: Int16 = 330   // seconds per km
    
    //TODO: Add methods here to calculate hours, minutes, seconds if type == time?
    
    
    
    
}
