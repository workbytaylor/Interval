//
//  EditView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-23.
//

import SwiftUI
import CoreData

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @ObservedObject private var workout: Workout
    @FetchRequest private var steps: FetchedResults<Step>
    
    init(workout: Workout) {
        
        self.workout = workout
        _steps = FetchRequest(
            entity: Step.entity(),
            sortDescriptors: [
                NSSortDescriptor(keyPath: \Step.index, ascending: true)
            ],
            predicate: NSPredicate(format: "workout == %@", workout)
        )
    }
    
    var body: some View {
        List {
            Section {
                TextField("Add Title", text: $workout.title)
                    .autocorrectionDisabled(false)
                    .autocapitalization(.sentences)
                    .onAppear {
                        UITextField.appearance().clearButtonMode = .whileEditing
                    }
            } header: {
                Text("Title")
            }
            
            Section {
                ForEach(steps) { step in
                    NavigationLink {
                        EditStepView()
                    } label: {
                        DetailRowView(step: step)
                    }
                    .deleteDisabled(workout.stepArray.count < 2)
                }
                //.onDelete(perform: deleteStepWithOffsets)
                //.onMove()
                
            } header: {
                Text("Steps")
            }
            
            Button {
                    // TODO: Add step
            } label: {
                Label("Add Step", systemImage: "plus")
            }
            .listRowBackground(Color.accentColor.opacity(0.1))
            
        }
        .navigationTitle("Edit workout")
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
                    // TODO: save
                    dismiss()
                } label: {
                    Text("Save")
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(workout: Workout())
    }
}
