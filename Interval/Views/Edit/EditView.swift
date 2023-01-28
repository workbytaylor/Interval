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
                }
                Section(header: Text("Steps")) {
                    if vm.workout.stepArray.isEmpty {
                        HStack {
                            Spacer()
                            NoDataView(item: "step")
                            Spacer()
                        }
                        .listRowBackground(Color.clear)
                    } else {
                        ForEach(vm.workout.stepArray, id: \.id/*, editActions: .all*/) { step in
                            NavigationLink {
                                EditStepView()
                            } label: {
                                DetailRowView(step: step)
                            }
                            //.deleteDisabled(newSteps.count < 2)
                        }
                        .onDelete(perform: nil)
                    }
                }
            }
            .navigationTitle(vm.isNew ? "New workout" : "Edit workout")
            .navigationBarTitleDisplayMode(.inline)
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
                            //addTimeStep()
                            vm.addStep(type: "time")
                        } label: {
                            Label("Time", systemImage: "stopwatch")
                        }
                        Button {
                            //addDistanceStep()
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
