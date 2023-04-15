//
//  Workout.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-04-14.
//

import Foundation

public class Workout: ObservableObject, Identifiable {
    public let id: UUID = UUID()
    @Published var title: String = ""
    @Published var steps: [Step]
    
    init(steps: [Step], title: String) {
        self.steps = steps
        self.title = title
    }
    
}
