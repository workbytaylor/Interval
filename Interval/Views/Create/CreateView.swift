//
//  CreateView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-02-16.
//
// The purpose of this view is to create and edit a brand new workout, then to save this workout


import SwiftUI


struct CreateViewStep: Identifiable, Hashable {
    let id: UUID = UUID()
    var magnitude: Int16 = 5
    var pace: Int16 = 330   // seconds per km
    var type: String = "time"
    var unit: String = "minutes"
}

struct CreateView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @State private var title: String = ""
    @State private var createViewSteps: [CreateViewStep] = [CreateViewStep()]
    
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
                    ForEach($createViewSteps, id: \.self, editActions: .all) { $step in
                        NavigationLink {
                            //EditStepView(step: step)
                            FormView()
                        } label: {
                            HStack {
                                Image(systemName: step.type == "distance" ? "lines.measurement.horizontal" : "stopwatch")
                                
                                VStack(alignment: .leading) {
                                    Text("\(step.magnitude) \(step.unit)")
                                    
                                    let paceMinutes = step.pace/60
                                    let paceSeconds = step.pace%60
                                    
                                    Text("\(paceMinutes).\(paceSeconds) /km")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                        .deleteDisabled(createViewSteps.count < 2)
                    }
                } header: {
                    Text("Steps")
                }
            }
            
            Button {
                createViewSteps.append(CreateViewStep())
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
        let newWorkout = Workout(context: moc)
        newWorkout.id = UUID()
        newWorkout.title = title
        var index: Int16 = 0
        
        // add steps to new workout in CoreData
        for step in createViewSteps {
            let newStep = Step(context: moc)
            newStep.id = step.id
            index += 1
            newStep.index = index
            newStep.magnitude = step.magnitude
            newStep.pace = step.pace
            newStep.type = step.type
            newStep.unit = step.unit
            newStep.workout = newWorkout
        }
        try? moc.save()
    }
}
