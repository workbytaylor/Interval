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
    @State private var showEditView: Bool = false
    var provider = WorkoutsProvider.shared
    
    var body: some View {
        List {
            ForEach(workouts, id: \.id) { workout in
                NavigationLink {
                    DetailView(workout: workout)
                } label: {
                    ContentRowView(workout: workout)
                }
            }
        }
        .navigationTitle("Workouts")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    showEditView.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showEditView) {
            EditView(vm: .init(provider: provider))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContentView()
                .environment(\.managedObjectContext, DataController().container.viewContext)
        }
    }
}
