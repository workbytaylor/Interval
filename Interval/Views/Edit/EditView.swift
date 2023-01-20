//
//  EditView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-23.
//

import SwiftUI

struct EditView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State var newTitle = ""
    @State var newSteps = [TempStep]()
    
    @State var navigationTitle: String = "Title"
    @State private var showStepEditor: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section/*(footer: Text("Error message here").foregroundColor(.red))*/ {
                    TextField("Add Title", text: $newTitle)
                        .font(.system(.title2, design: .default, weight: .semibold))
                        .autocorrectionDisabled(false)
                        .autocapitalization(.sentences)
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
                    ForEach($newSteps, id: \.id, editActions: .all) { $step in
                        NavigationLink {
                            EditStepView()
                        } label: {
                            HStack {
                                // change to switch statement when more step types are added
                                Image(systemName: step.type == "distance" ? "lines.measurement.horizontal" : "stopwatch")
                                VStack(alignment: .leading) {
                                    Text("\(step.magnitude) \(step.unit)")
                                        //.font(.headline)
                                    Text(step.pace)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                                .padding(.leading)
                            }
                        }
                        .deleteDisabled(newSteps.count < 2)
                    }
                }
            }
            .background(Color(red: 242/255, green: 241/255, blue: 247/255))
            .navigationTitle(navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                addFirstStep()
            }
            .sheet(isPresented: $showStepEditor) {
                EditStepView()
                    .presentationDetents([.large])
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(role: .cancel) {
                        dismiss()
                    } label: {
                        Text("Cancel").tint(.red)
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        createWorkout()
                    } label: {
                        Text("Save")
                    }
                    .disabled(newTitle == "" || newSteps.count == 0)
                }
                ToolbarItem(placement: .bottomBar) {
                    Menu {
                        Button {
                            addTimeStep()
                        } label: {
                            Label("Time", systemImage: "stopwatch")
                        }
                        Button {
                            addDistanceStep()
                        } label: {
                            Label("Distance", systemImage: "lines.measurement.horizontal")
                        }
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("Add Step")
                        }
                    }
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        EditView()
    }
}
