//
//  TestView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-01-06.
//

import SwiftUI

struct TestView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.title)]) var workouts: FetchedResults<Workout>
    
    let newWorkout: Workout
    
    
    var body: some View {
        NavigationStack {
            List(workouts) { workout in
                NavigationLink(workout.wrappedTitle, value: workout)
            }
            .navigationTitle("Workouts")
            .navigationDestination(for: Workout.self) { workout in
                DetailView(workout: workout, showEditView: true)
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    NavigationLink("plus", value: newWorkout)
                        
                }
                
            }
        }
        
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TestView(newWorkout: Workout())
                .environment(\.managedObjectContext, DataController().container.viewContext)
        }
    }
}
