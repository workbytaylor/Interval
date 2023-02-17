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
    @Environment(\.managedObjectContext) var moc    // is this needed?
    @FetchRequest(fetchRequest: Workout.all()) private var workouts
    
    @State private var searchConfig: SearchConfig = .init()
    @State private var showSheet: Bool = false
    
    var body: some View {
        ZStack {
            if workouts.isEmpty {
                NoDataView(item: "Workouts")
            } else {
                List {
                    ForEach(workouts) { workout in
                        NavigationLink {
                            DetailView(workout: workout)
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
                    showSheet.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showSheet) {
            NavigationStack {
                CreateView(newWorkout: Workout(), steps: )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
