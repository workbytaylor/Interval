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
        NavigationStack {
            ZStack {
                if workouts.isEmpty {
                    NoDataView(item: "workout")
                } else {
                    List {
                        ForEach(workouts, id: \.id) { workout in
                            NavigationLink {
                                DetailView(workout: workout)
                            } label: {
                                ContentRowView(workout: workout)
                            }
                        }
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let preview = WorkoutsProvider.shared
        ContentView(provider: preview)
            .environment(\.managedObjectContext, preview.viewContext)
            .onAppear{ Workout.makePreview(count: 10, in: preview.viewContext) }
            .previewDisplayName("Workouts with data")
        
        let emptyPreview = WorkoutsProvider.shared
        ContentView(provider: emptyPreview)
            .environment(\.managedObjectContext, emptyPreview.viewContext)
            .previewDisplayName("Workouts with no data")
    }
}
