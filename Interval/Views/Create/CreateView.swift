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
    
    @State private var title: String = ""
    @State var steps: [Step] = [Step()]
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            List {
                Section {
                    TextField("Add Title", text: $title)
                        .autocorrectionDisabled(false)
                        .autocapitalization(.sentences)
                        .onAppear {
                            UITextField.appearance().clearButtonMode = .whileEditing
                        }
                } header: {
                    Text("Title")
                }
                
                Section {
                    // list all steps in new workout
                    ForEach($steps, id: \.id, editActions: .all) { $step in
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
                                    
                                    VStack(alignment: .leading) {
                                        //magnitude + unit
                                        switch step.type {
                                        case "distance":
                                            Text("\(step.length) \(step.unit)")
                                        case "time":
                                            HStack {
                                                step.hours>0 ? Text("\(step.hours)h") : nil
                                                step.minutes>0 ? Text("\(step.minutes)m") : nil
                                                step.seconds>0 ? Text("\(step.seconds)s") : nil
                                            }
                                        default:
                                            Text("Unknown step type")
                                        }
                                        
                                        Text("\(step.paceMinutes).\(step.paceSeconds) /km")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                            }
                            
                            Image(systemName: "line.3.horizontal").foregroundStyle(.secondary)
                        }
                        .deleteDisabled(steps.count < 2)
                    }
                    
                } header: {
                    Text("Steps")
                }
            }
            
            Button {
                steps.append(Step())
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
                .disabled(title.isEmpty)
            }
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}


extension CreateView {
    
    // workout is not created until the save button is tapped
    private func saveNewWorkout() {
        let newWorkout = CoreDataWorkout(context: moc)
        newWorkout.id = UUID()
        newWorkout.title = title
        var index: Int16 = 0
        
        // add steps to new workout in CoreData
        for step in steps {
            let newStep = CoreDataStep(context: moc)
            newStep.id = step.id
            index += 1
            newStep.index = index
            // TODO: Change this for each type -> switch statement?
            newStep.magnitude = step.length
            newStep.pace = step.pace
            newStep.type = step.type
            newStep.unit = step.unit
            newStep.cdWorkout = newWorkout
        }
        try? moc.save()
    }
}
