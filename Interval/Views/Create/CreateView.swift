//
//  CreateView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-02-16.
//

import SwiftUI

struct CreateView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @State var newWorkout: Workout
    @State var title: String = ""
    @FetchRequest var steps: FetchedResults<Step>
    //@FetchRequest var workout: FetchedResults<Workout>
    
    init() {
        self.newWorkout = 
        
        _steps = FetchRequest(
            entity: Step.entity(),
            sortDescriptors: [
                NSSortDescriptor(keyPath: \Step.index, ascending: true)
            ],
            predicate: NSPredicate(format: "workout == %@", newWorkout)
        )
    }
    
    
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
                if steps.isEmpty {
                    // no steps
                    NoDataView(item: "Steps")
                } else {
                    // list steps
                    ForEach(steps) { step in
                        DetailRowView(step: step)
                    }
                }
            } header: {
                Text("Steps")
            }
            
            // add step button
            Section {
                Button {
                    withAnimation {
                        // add step
                        let newStep = Step(context: moc)    // TODO: Fix this list
                        //newStep.workout = newWorkout
                    }
                } label: {
                    Label("Add Step", systemImage: "plus")
                }
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
          //  let newWorkout = Workout(context: moc)
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
        // add steps to workout?
        try? moc.save()
    }
}
