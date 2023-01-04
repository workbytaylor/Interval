//
//  DetailView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-26.
//

import SwiftUI

struct DetailView: View {
    
    @ObservedObject var workout: Workout
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    //@State private var editMode: Bool = false
    @State private var showDeleteAlert: Bool = false
    @State private var showEditView: Bool = false
    
    var body: some View {
        VStack(spacing: .zero) {
            List {
                ForEach(workout.stepArray, id: \.id) { step in
                    HStack {
                        //Text(String(step.index))
                        Image(systemName: step.type == "distance" ? "lines.measurement.horizontal" : "stopwatch")
                            .frame(width: 40)
                        VStack(alignment: .leading) {
                            Text(String(step.magnitude))+Text(" \(step.wrappedUnit)")
                            Text(step.wrappedPace)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
        }
        .background(Color(red: 242/255, green: 241/255, blue: 247/255))
        .navigationBarTitle(workout.wrappedTitle)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Menu {
                    Button { showEditView.toggle() } label: { Label("Edit Workout", systemImage: "square.and.pencil") }
                    Button(role: .destructive) { showDeleteAlert = true } label: { Label("Delete Workout", systemImage: "trash") }
                    // TODO: Change Edit Steps to show modal sheet, edit steps and info there
                    // TODO: After doing above, remove edit and move fxns on DetailView
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
        }
        .sheet(isPresented: $showEditView) {
            EditView(/*workout: workout*/)
        }
        .alert("Delete Workout", isPresented: $showDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteWorkout)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
    }
}

/*
struct DetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        DetailView()
            //.environment(\.managedObjectContext, DataController().container.viewContext)
    }
}
*/
