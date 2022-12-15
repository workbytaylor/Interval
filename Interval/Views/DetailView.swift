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
    @Environment(\.dismiss) private var dismiss
    @Environment(\.editMode) private var editMode
    @State private var showDeleteAlert: Bool = false
    
    var body: some View {
            VStack(spacing: .zero) {
                List {
                    ForEach(workout.stepArray, id: \.id) { step in
                        HStack {
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
                    //.onDelete(perform: deleteStep)
                    .onMove(perform: nil)
                }
                .listStyle(.insetGrouped)
                
                if editMode?.wrappedValue.isEditing == true {
                    HStack {
                        Button {
                            // add distance step
                        } label: {
                            HStack {
                                Label("Distance", systemImage: "lines.measurement.horizontal")
                                Spacer()
                                Image(systemName: "plus")
                            }
                        }
                        Button {
                            // add time step
                        } label: {
                            HStack {
                                Label("Time", systemImage: "stopwatch")
                                Spacer()
                                Image(systemName: "plus")
                            }
                        }
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                    .padding()
                    .background(Color(red: 242/255, green: 241/255, blue: 247/255))
                } else {
                    Button {
                        // start run
                    } label: {
                        HStack {
                            Spacer()
                            Text("Start")
                            Spacer()
                        }
                        
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .padding()
                    .background(Color(red: 242/255, green: 241/255, blue: 247/255))
                }
            }
            .navigationTitle(workout.wrappedTitle)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if editMode?.wrappedValue.isEditing == true {
                        Button(role: .destructive) {
                            showDeleteAlert = true
                        } label: {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                    
                    EditButton()
                    
                }
            }
            .alert("Delete workout", isPresented: $showDeleteAlert) {
                Button("Delete", role: .destructive, action: deleteWorkout)
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Are you sure?")
            }
        
    }
    
    private func deleteWorkout() {
        moc.delete(workout)
        if moc.hasChanges {
            try? moc.save()
        }
        dismiss()   //returns to ContentView after delete
    }
    
}

/*
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
*/
