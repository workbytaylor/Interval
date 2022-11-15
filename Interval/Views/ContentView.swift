//
//  ContentView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-13.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showNewSheet: Bool = false
    @State private var workouts = [Workout]()
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            
            List {
                ForEach(workouts, id: \.title) { workout in
                    Text(workout.title) // empty because there is no sample data
                }
                
                NavigationLink {
                    Text("Workout 1")
                } label: {
                    Text("Workout title")
                        .font(.headline)
                }
            }
            .navigationTitle("Workouts")
            .toolbar {
                ToolbarItem {
                    Button {
                        showNewSheet.toggle()
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


extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var workouts: [Workout]
        
        init() {
            workouts = []
        }
        
    }
}
