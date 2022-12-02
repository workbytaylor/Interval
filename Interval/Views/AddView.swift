//
//  AddView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-23.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var workouts: Workouts
    //viewmodel for this may be helpful? likely yes.
    @State var newWorkout: Workout = Workout()
    @State var newTitle: String = ""
    @State var newSteps: [Step] = []
    @State var newIndex: Int = 1
    
    var body: some View {
        NavigationStack {
            VStack(spacing: .zero) {
                List {
                    Section(header: Text("Title")) {
                        TextField("Workout title", text: $newTitle)
                            .autocorrectionDisabled(false)
                        // TODO: auto capilization
                        // TODO: check for other titles that match current input
                        .overlay(alignment: .trailing) {
                            if newTitle != "" {
                                Button {
                                    newTitle = ""
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                }
                                .foregroundStyle(.secondary)
                            }
                        }
                    }
                    
                    Section(header: Text("Steps")) {
                        if newSteps.count != 0 {
                            ForEach(newSteps, id: \.index) { step in
                                HStack {
                                    Image(systemName: step.type == "distance" ? "lines.measurement.horizontal" : "stopwatch")
                                        .frame(width: 40)
                                    VStack(alignment: .leading) {
                                        Text(String(step.target.magnitude))+Text(" \(step.target.unit)")
                                        Text(step.pace)
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                            }
                            .onDelete(perform: deleteStep)  // TODO: renumber later steps
                        } else {
                            HStack {
                                Spacer()
                                Text("Tap")
                                Image(systemName: "plus")
                                Text("to add a step")
                                Spacer()
                            }
                            .foregroundStyle(.secondary)
                            .listRowBackground(Color.clear)
                        }
                    }
                }
                VStack {
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
                .buttonStyle(.bordered)
                .padding()
                .background(Color(red: 242/255, green: 241/255, blue: 247/255))
                
            }
            .navigationTitle("Add a workout")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(role: .cancel) {
                        dismiss()
                    } label: {
                        Text("Cancel").tint(.red)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if newTitle == "" || newSteps.count == 0 {
                        Text("Save")
                            .foregroundStyle(.secondary)
                            .bold()
                    } else {
                        Button {
                            saveNewWorkout()
                        } label: {
                            Text("Save")
                                .bold()
                        }
                    }
                }
            }
        }
    }
    
    private func deleteStep(at offsets: IndexSet) {
        newSteps.remove(atOffsets: offsets)
    }
    
    private func addTimeStep() {
        let timeStep: Step = Step()
        timeStep.type = "time"
        timeStep.target.magnitude = 5
        timeStep.target.unit = "minutes"
        timeStep.index = newSteps.count+1
        newSteps.append(timeStep)
    }
    
    private func addDistanceStep() {
        let distanceStep: Step = Step()
        distanceStep.type = "distance"
        distanceStep.index = newSteps.count+1
        newSteps.append(distanceStep)
    }
    
    private func saveNewWorkout() {
        newWorkout.title = newTitle
        newWorkout.steps = newSteps
        workouts.allworkouts.append(newWorkout)
        dismiss()
    }
    
    
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
            .environmentObject(Workouts())
    }
}
