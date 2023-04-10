//
//  Workout.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-04-09.
//

import Foundation

public class Workout: ObservableObject, Identifiable {
    public let id: UUID = UUID()
    @Published var title: String = ""
    @Published var steps: [Step] = [Step()]
    
    
    
}
