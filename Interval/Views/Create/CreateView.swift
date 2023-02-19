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
            
            Section {   // steps
                if steps == [] {
                    HStack {
                        Spacer()
                        NoDataView(item: "Steps")
                        Spacer()
                    }
                    .listRowBackground(Color.clear)
                } else {
                    // list steps
                    
                    Section {
                        ForEach(steps) { step in
                            DetailRowView(step: step)
                        }
                    } header: {
                        Text("Steps")
                    }
                    
                    Section {
                        Button {
                            withAnimation {
                                // add step
                                steps.append(Step())    // TODO: This may not be right
                            }
                        } label: {
                            Label("Add Step", systemImage: "plus")
                        }
                    }
                    .listRowBackground(Color.accentColor.opacity(0.1))
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
    
    // workout is not created until the save button is tapped
    func saveNewWorkout() {
        let newWorkout = Workout(context: moc)
        newWorkout.id = UUID()
        newWorkout.title = title
        // add steps to workout?
        try? moc.save()
    }
    
    
    
    
}
