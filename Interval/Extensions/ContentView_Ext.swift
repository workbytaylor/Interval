//
//  ContentView_Ext.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-01-04.
//

import Foundation
import SwiftUI

extension ContentView {
    
    var noWorkoutsView: some View {
        HStack {
            Spacer()
            Text("Tap")
            Image(systemName: "plus")
            Text("to create a workout")
            Spacer()
        }
        .listRowBackground(Color.clear)
        .foregroundStyle(.secondary)
    }
    
    func createWorkout() {
        let newWorkout = Workout(context: moc)
        newWorkout.id = UUID()
        //newWorkout.title = vm.newTitle
        //createSteps(newWorkout)
        //save()
        //dismiss()
    }
    
    
    
}