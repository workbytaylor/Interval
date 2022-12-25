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
    @Environment(\.editMode) private var editMode
    @State private var addSteps: Bool = false
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
                
                if addSteps == true {
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
                            Text("Start workout on apple watch")
                            Spacer()
                        }
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                    .padding()
                    .background(Color(red: 242/255, green: 241/255, blue: 247/255))
                }
            }
            .navigationTitle(workout.wrappedTitle)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    // TODO: Change to 3 dot menu
                    if addSteps == true {
                        Button(role: .destructive) {
                            showDeleteAlert = true
                        } label: {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                    Button {
                        addSteps.toggle()
                    } label: {
                        Image(systemName: addSteps == false ? "square.and.pencil" : "checkmark")
                    }
                }
            }
            .alert("Delete workout", isPresented: $showDeleteAlert) {
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
    }
}
*/
