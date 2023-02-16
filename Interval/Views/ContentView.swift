//
//  ContentView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-13.
//

import SwiftUI
import CoreData

struct SearchConfig: Equatable {
    var query: String = ""
}

struct ContentView: View {
    @FetchRequest(fetchRequest: Workout.all()) private var workouts
    @State private var workoutToEdit: Workout?
    @State private var searchConfig: SearchConfig = .init()
    var provider = WorkoutsProvider.shared
    
    var body: some View {
        NavigationStack {
            ZStack {
                // change to switch statement with different cases
                // add case for search, but no views match
                if workouts.isEmpty {
                    NoDataView(item: "Workouts")
                } else {
                    List {
                        ForEach(workouts, id: \.id) { workout in
                            NavigationLink {
                                DetailView(workout: workout, provider: provider)
                            } label: {
                                ContentRowView(workout: workout)
                            }
                        }
                    }
                }
            }
            .searchable(text: $searchConfig.query)
            .navigationTitle("Workouts")
            .onChange(of: searchConfig) { newValue in
                workouts.nsPredicate = Workout.filter(newValue.query)
            }
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
                   onDismiss: { workoutToEdit = nil },
                   content: { workout in
                        EditView(provider: provider,
                                 workout: workout
                        )
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
