//
//  ContentView-ViewModel.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-15.
//

import Foundation


extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var workouts: [Workout]
        
        init() {
            workouts = []
        }
        
        func addWorkout() {
            let newWorkout = Workout(
                id: UUID(),
                title: "New workout",
                steps: [Step(id: UUID(), index: 1, targetType: "distance", target: Target(magnitude: 800, unit: "meters"), pace: "5:15 m/km")]
            )
            
            workouts.append(newWorkout)
            
        }
        
        
    }
}
