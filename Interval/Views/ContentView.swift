//
//  ContentView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-13.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()
    @State private var showAddView: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.workouts, id: \.id) { workout in
                    NavigationLink {
                        WorkoutView(workout: workout)
                    } label: {
                        Text(workout.title)
                    }
                }
                .onDelete(perform: viewModel.deleteWorkout)    // unsure how to fix
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Workouts")
            .toolbar {
                ToolbarItem {
                    Button {
                        showAddView.toggle()
                        //viewModel.addWorkout()
                        print(viewModel.workouts)
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
