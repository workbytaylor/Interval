//
//  ContentView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-13.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var showEditView: Bool = false
    
    @FetchRequest(fetchRequest: Workout.all()) private var workouts
    
    var provider = WorkoutsProvider.shared
    
    var body: some View {
        List {
            ForEach(workouts, id: \.id) { workout in
                NavigationLink {
                    DetailView(/*workout: workout*/)
                } label: {
                    ContentRowView()
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
