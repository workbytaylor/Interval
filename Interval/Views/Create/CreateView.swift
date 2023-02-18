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
    //@State var newWorkout: Workout
    @State var title: String = ""
    @State var steps: [Step] = []
    
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
            
            Section {   // list steps
                if steps == [] {
                    HStack {
                        Spacer()
                        NoDataView(item: "Steps")
                        Spacer()
                    }
                    .listRowBackground(Color.clear)
                } else {
                    // list setps
                }
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
    func saveNewWorkout() {
        let newWorkout = Workout(context: moc)
        newWorkout.id = UUID()
        newWorkout.title = title
        // add steps to workout?
        try? moc.save()
    }
    
}
