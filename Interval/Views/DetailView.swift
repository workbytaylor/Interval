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
    @State private var editMode: Bool = false
    @State private var showDeleteAlert: Bool = false
    
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
                    .onDelete(perform: deleteStep)
                    .onMove(perform: nil)   //TODO: Move function
                    
                }
                .listStyle(.insetGrouped)
                
                if editMode == true {
                    HStack {
                        Button {
                            addDistanceStep()
                        } label: {
                            HStack {
                                Label("Distance", systemImage: "lines.measurement.horizontal")
                                Spacer()
                                Image(systemName: "plus")
                            }
                        }
                        Button {
                            addTimeStep()
                        } label: {
                            HStack {
                                Label("Time", systemImage: "stopwatch")
                                Spacer()
                                Image(systemName: "plus")
                            }
                        }
                    }
                    .buttonStyle(.borderedProminent)
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
                }
            }
            .background(Color(red: 242/255, green: 241/255, blue: 247/255))
            .navigationBarTitle(workout.wrappedTitle)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if editMode == false {
                        Menu {
                            Button(role: .destructive) { showDeleteAlert = true } label: { Label("Delete Workout", systemImage: "trash") }
                            // TODO: Change Edit Steps to show modal sheet, edit steps and info there
                            // TODO: After doing above, remove edit and move fxns on DetailView
                            Button { editMode.toggle() } label: { Label("Edit Steps", systemImage: "square.and.pencil") }
                        } label: {
                            Image(systemName: "ellipsis")
                        }
                    } else {
                        Button { editMode.toggle() } label: { Image(systemName: "checkmark") }
                    }
                }
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
