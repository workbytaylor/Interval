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
                        Text("to create your first workout.")
                        Spacer()
                    }
                    .listRowBackground(Color.clear)
                    .foregroundStyle(.secondary)
                } else {
                    ForEach(workouts.allworkouts, id: \.id) { workout in
                        NavigationLink {
                            Text(workout.title)
                            //workoutview
                        } label: {
                            Text(workout.title)
                        }
                    }
                    .onDelete(perform: workouts.deleteWorkout)  // unsure how to fix
                }
                
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Workouts")
            .toolbar {
                ToolbarItem {
                    Button {
                        //workouts.addWorkout()
                        showAddView.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddView) {
                AddView()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
