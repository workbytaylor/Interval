//
//  EditView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-23.
//

import SwiftUI

struct EditView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: EditWorkoutViewModel
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Add Title", text: $vm.workout.title)
                        .font(.system(.title2, design: .default, weight: .semibold))
                        .autocorrectionDisabled(false)
                        .autocapitalization(.sentences)
                      /*
                        .overlay(alignment: .trailing) {
                            if vm.workout.title != "" {
                                Button {
                                    vm.workout.title = ""
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                }
                                .foregroundStyle(.secondary)
                            }
                        }
                    */
                } header: {
                    Text("Title")
                }
                
                Section {
                    if vm.workout.stepArray.isEmpty {
                        HStack {
                            Spacer()
                            NoDataView(item: "step")
                            Spacer()
                        }
                        .listRowBackground(Color.clear)
                    } else {
                        ForEach(vm.workout.stepArray, id: \.id) { step in
                            NavigationLink {
                                EditStepView()
                            } label: {
                                DetailRowView(step: step)
                            }
                            //.deleteDisabled(newSteps.count < 2)
                        }
                        .onDelete(perform: nil)
                    }
                } header: {
                    Text("Steps")
                }
            }
            .navigationTitle(vm.isNew ? "New workout" : "Edit workout")
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
                        do {
                            try vm.save()
                            dismiss()
                        } catch {
                            print(error)
                        }
                    } label: {
                        Text("Save")
                    }
                    .disabled(!vm.workout.isValid)  // or if steps == 0
                }
                ToolbarItem(placement: .bottomBar) {
                    Menu {
                        Button {
                            vm.addStep(type: "time")
                            //vm.workout.objectWillChange.send()
                            
                        } label: {
                            Label("Time", systemImage: "stopwatch")
                        }
                        Button {
                            vm.addStep(type: "distance")
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
        let preview = WorkoutsProvider.shared
        EditView(vm: .init(provider: preview))
            .environment(\.managedObjectContext, preview.viewContext)
    }
}
