//
//  ContentView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-13.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @FetchRequest(fetchRequest: Workout.all()) private var workouts
    @State private var workoutToEdit: Workout?
    var provider = WorkoutsProvider.shared
    
    var body: some View {
        NavigationStack {
            ZStack {
                if workouts.isEmpty {
                    NoDataView(item: "workout")
                } else {
                    List {
                        ForEach(workouts, id: \.id) { workout in
                            NavigationLink {
                                DetailView(workout: workout, provider: provider)
                            } label: {
                                ContentRowView(workout: workout)
                            }
                        }
                        //.listRowSeparator(.hidden)
                    }
                    //.listStyle(.plain)
                }
            }
            .navigationTitle("Workouts")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        workoutToEdit = .empty(context: provider.newContext)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(item: $workoutToEdit,
                   onDismiss: {
                        workoutToEdit = nil
                }, content: { workout in
                EditView(vm: .init(provider: provider,
                                  workout: workout))
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let preview = WorkoutsProvider.shared
        ContentView(provider: preview)
            .environment(\.managedObjectContext, preview.viewContext)
            .onAppear{ Workout.makePreview(count: 4, in: preview.viewContext) }
            .previewDisplayName("Workouts with data")
        
        let emptyPreview = WorkoutsProvider.shared
        ContentView(provider: emptyPreview)
            .environment(\.managedObjectContext, emptyPreview.viewContext)
            .previewDisplayName("Workouts with no data")
    }
}
