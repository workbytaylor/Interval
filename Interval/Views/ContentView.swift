//
//  ContentView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-13.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.title)]) var workouts: FetchedResults<Workout>
    
    @State private var showAddView: Bool = false
    
    var body: some View {
        List {
            if !workouts.isEmpty {
                ForEach(workouts, id: \.id) { workout in
                    NavigationLink {
                        DetailView(workout: workout)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(workout.wrappedTitle)
                                .font(.headline)
                            Text("\(workout.stepArray.count) steps")
                                .foregroundStyle(.secondary)
                                .font(.subheadline)
                        }
                    }
                }
            } else {
                noWorkoutsView
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Workouts")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
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


private extension ContentView {
    
    var noWorkoutsView: some View {
        HStack {
            Spacer()
            Text("Tap")
            Image(systemName: "plus")
            Text("to create a workout")
            Spacer()
        }
        .listRowBackground(Color.clear)
        .foregroundStyle(.secondary)
    }
        
    
    
    
    
    
    
    
}
