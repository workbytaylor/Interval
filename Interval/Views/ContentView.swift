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
    @State private var searchConfig: SearchConfig = .init()
    @State private var showSheet: Bool = false
    
    var body: some View {
            ZStack {
                // change to switch statement with different cases
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
                CreateView()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
