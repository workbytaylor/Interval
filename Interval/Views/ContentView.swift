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
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: CoreDataWorkout.all()) private var workouts
    @State private var searchConfig: SearchConfig = .init()
    @State private var showSheet: Bool = false
    
    var body: some View {
        ZStack {
            if workouts.isEmpty {
                NoDataView()
            } else {
                List {
                    ForEach(workouts) { workout in
                        NavigationLink {
                            DetailView(workout: workout)
                        } label: {
                            
                            VStack(alignment: .leading) {
                                Text(workout.title)
                                    .font(.headline)
                                Text("20 Min | 5 km")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            
                            /*
                            LabeledContent {
                                
                            } label: {
                                Text(workout.title)
                                Text("20 Min | 5 km")
                            }
                            */
                        }
                    }
                }
            }
        }
        .searchable(text: $searchConfig.query)
        .navigationTitle("Workouts")
        .onChange(of: searchConfig) { newValue in
            workouts.nsPredicate = CoreDataWorkout.filter(newValue.query)
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
                CreateView(workout: Workout(steps: [Step()], title: ""))
                    .interactiveDismissDisabled()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
