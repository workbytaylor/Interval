//
//  ContentView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-13.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.title)]) var workouts: FetchedResults<Workout>
    
    @State private var showEditView: Bool = false
    
    
    var body: some View {
        List {
            if !workouts.isEmpty {
                ForEach(workouts, id: \.id) { workout in
                    NavigationLink {
                        DetailView(workout: workout, showEditView: false)
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
        .navigationTitle("Workouts")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                //https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-programmatic-navigation-in-swiftui
                /*
                Button {
                    showEditView.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                */
                
                
            }
            
            // move this to cancel button in EditView
            // undoes all actions since previous save
            /*
            Button {
                moc.rollback()    //undo all since prev save
            } label: {
                Text("Undo")
            }
            */
            
        }
        .sheet(isPresented: $showEditView) {
            EditView(title: "New Workout")
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
