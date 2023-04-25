//
//  CreateView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-02-16.
//
// The purpose of this view is to create, edit and save a new workout


import SwiftUI

struct CreateView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    
    @ObservedObject var workout: Workout
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            List {
                Section {
                    TextField("Add Title", text: $workout.title)
                        .autocorrectionDisabled(false)
                        .autocapitalization(.sentences)
                        .onAppear { // Funny, this applies to all child views as well
                            UITextField.appearance().clearButtonMode = .whileEditing
                        }
                } header: {
                    Text("Title")
                }
                
                Section {
                    // list all steps in new workout
                    ForEach($workout.steps, id: \.id, editActions: .all) { $step in
                        HStack {
                            NavigationLink {
                                FormView(step: $step)
                            } label: {
                                HStack {
                                    // TODO: Replace with reusable view later
                                    switch step.type {
                                    case "distance":
                                        Image(systemName: "lines.measurement.horizontal")
                                    case "time":
                                        Image(systemName: "stopwatch")
                                    default:
                                        Image(systemName: "xmark")
                                    }
                                    
                                    LabeledContent {
                                        Text("\(step.paceMinutes).\(step.paceSeconds) /km")
                                    } label: {
                                        switch step.type {
                                        case "distance":
                                            Text("\(step.length) \(step.unit)")
                                                //.font(.headline)
                                        case "time":
                                            HStack {
                                                step.hours>0 ? Text("\(step.hours)hr") : nil
                                                step.minutes>0 ? Text("\(step.minutes)min") : nil
                                                step.seconds>0 ? Text("\(step.seconds)sec") : nil
                                            }
                                            //.font(.headline)
                                        default:
                                            Text("Unknown step type")
                                        }
                                    }
                                    
                                    
                                    /*
                                    VStack(alignment: .leading) {
                                        //magnitude + unit
                                        switch step.type {
                                        case "distance":
                                            Text("\(step.length) \(step.unit)")
                                                .font(.headline)
                                        case "time":
                                            HStack {
                                                step.hours>0 ? Text("\(step.hours)hr") : nil
                                                step.minutes>0 ? Text("\(step.minutes)min") : nil
                                                step.seconds>0 ? Text("\(step.seconds)sec") : nil
                                            }
                                            .font(.headline)
                                        default:
                                            Text("Unknown step type")
                                        }
                                        
                                        // TODO: Add option for no pace Text("No pace")
                                        // TODO: Add leading zero for 0 seconds option
                                        
                                        Text("\(step.paceMinutes).\(step.paceSeconds) /km")
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                    }
                                     */
                                }
                            }
                        }
                        .deleteDisabled(workout.steps.count < 2)
                    }
                    
                } header: {
                    Text("Steps")
                }
            }
            
            Button {
                workout.steps.append(Step())
            } label: {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .font(.headline)
            }
            .frame(width: 60, height: 60)
            .background(Color.accentColor)
            .clipShape(Circle())
            //.shadow(color: .gray, radius: 2, x: 0, y: 2)
            .padding()
        }
        .navigationTitle("New workout")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(role: .cancel) {
                    dismiss()
                } label: {
                    Text("Cancel").tint(.red)
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    saveNewWorkout()
                    dismiss()
                } label: {
                    Text("Save")
                }
                .disabled(workout.title.isEmpty)
            }
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView(workout: Workout(steps: [Step()], title: ""))
    }
}


extension CreateView {
    
    // workout is not created until the save button is tapped
    private func saveNewWorkout() {
        let newWorkout = CoreDataWorkout(context: moc)
        newWorkout.id = UUID()
        newWorkout.title = workout.title
        var index: Int16 = 0
        
        // add steps to new workout in CoreData
        for step in workout.steps {
            let newStep = CoreDataStep(context: moc)
            newStep.id = step.id
            index += 1
            newStep.index = index
            // TODO: Change this for each type -> switch statement?
            newStep.hours = step.hours
            newStep.minutes = step.minutes
            newStep.seconds = step.seconds
            newStep.length = step.length
            newStep.paceMinutes = step.paceMinutes
            newStep.paceSeconds = step.paceSeconds
            newStep.type = step.type
            newStep.unit = step.unit
            newStep.cdWorkout = newWorkout
        }
        try? moc.save()
    }
}
