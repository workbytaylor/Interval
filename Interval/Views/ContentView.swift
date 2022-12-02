//
//  ContentView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-13.
//
// Writing on MergeViewModels branch - correct? yes/no

import SwiftUI

struct ContentView: View {
    
    @StateObject var workouts = Workouts()
    @State private var showAddView: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                if workouts.allworkouts.count == 0 {
                    HStack {
                        Spacer()
                        Text("Tap")
                        Image(systemName: "plus")
                        Text("to create a workout")
                        Spacer()
                    }
                    .listRowBackground(Color.clear)
                    .foregroundStyle(.secondary)
                } else {
                    ForEach(workouts.allworkouts, id: \.id) { workout in
                        NavigationLink {
                            DetailView(workout: workout)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(workout.title)
                                    .font(.headline)
                                Text("\(workout.steps.count) steps")
                                    .foregroundStyle(.secondary)
                                    .font(.subheadline)
                            }
                        }
                    }
                    //.onDelete(perform: workouts.deleteWorkout)  // unsure how to fix
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Workouts")
            .toolbar {
                ToolbarItem {
                    Button {
                        showAddView.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddView) {
                AddView()
            }
            .environmentObject(workouts)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
