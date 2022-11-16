//
//  ContentView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-13.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()
    @State private var showNewSheet: Bool = false
    
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
            }
            .navigationTitle("Workouts")
            .toolbar {
                ToolbarItem {
                    Button {
                        //showNewSheet.toggle()
                        viewModel.addWorkout()
                        print(viewModel.workouts)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showNewSheet) {
                NewView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
