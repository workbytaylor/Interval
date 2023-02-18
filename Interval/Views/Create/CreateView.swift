//
//  CreateView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-02-16.
//

import SwiftUI

struct CreateView: View {
    @Environment(\.dismiss) var dismiss
    @State var newWorkout: Workout = Workout()
    @State var steps: [Step] = [Step()]
    
    var body: some View {
        List {
            Section {
                TextField("Add Title", text: $newWorkout.title)
                    .autocorrectionDisabled(false)
                    .autocapitalization(.sentences)
                    .onAppear {
                        UITextField.appearance().clearButtonMode = .whileEditing
                    }
            } header: {
                Text("Title")
            }
            
            Section {
                // list steps
                
                
                
                
            } header: {
                Text("Steps")
            }
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
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView(newWorkout: Workout(), steps: [])
    }
}
