//
//  ContentView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-13.
//

import SwiftUI
import CoreData

struct ContentView: View {
    /*
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.title)]) var workouts: FetchedResults<Workout>
    */
    
    var provider = WorkoutsProvider.shared
    @State private var showEditView: Bool = false
    
    
    var body: some View {
        List {
            /*if workouts.isEmpty {
                noWorkoutsView
            } else {*/
            ForEach((1...10), id: \.self) { workout in
                NavigationLink {
                    DetailView(/*workout: workout*/)
                } label: {
                    ContentRowView()
                }
            }
            //}
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
