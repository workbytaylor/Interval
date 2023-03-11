//
//  CreateView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-02-16.
//

import SwiftUI


struct CreateViewStep: Identifiable {
    let id: UUID = UUID()
    var index: Int16
    var magnitude: Int16 = 5
    var pace: Int16 = 330   // seconds per km
    var type: String = "time"
    var unit: String = "minutes"
}

struct CreateView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @State private var title: String = ""
    @State private var createViewSteps: [CreateViewStep] = []
    
    var body: some View {
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
                ForEach(createViewSteps) { step in
                    HStack {
                        Text(String(step.index))
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
            } header: {
                Text("Steps")
            }
            
            // add new step to end of list
            Button {
                createViewSteps.append(CreateViewStep(index: Int16(createViewSteps.count+1)))
            } label: {
                Label("Add Step", systemImage: "plus")
            }
            .listRowBackground(Color.accentColor.opacity(0.1))
            
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
        //.onAppear {
          //  add first step?
        //}
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}


extension CreateView {
    
    // workout is not created until the save button is tapped
    func saveNewWorkout() {
        let newWorkout = Workout(context: moc)
        newWorkout.id = UUID()
        newWorkout.title = title
        
        // TODO: add steps to workout?
        
        try? moc.save()
    }
}
