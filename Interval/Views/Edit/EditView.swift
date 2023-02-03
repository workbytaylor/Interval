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
    @FocusState var isTitleFocused: Bool
    
    var provider = WorkoutsProvider.shared
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Add Title", text: $vm.workout.title)
                        .autocorrectionDisabled(false)
                        .autocapitalization(.sentences)
                        .focused($isTitleFocused)
                        .onAppear {
                            UITextField.appearance().clearButtonMode = .whileEditing
                        }
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
                            .deleteDisabled(vm.workout.stepArray.count < 2)
                            /*
                            .swipeActions {
                                Button(role: .destructive) {
                                    do {
                                        try vm.deleteStep(step)//provider.deleteStep(step, in: provider.viewContext)
                                    } catch {
                                        print(error)
                                    }
                                         
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                        .tint(.red)
                                }
                            }
                             */
                        }
                        .onDelete(perform: vm.deleteStepWithOffsets)
                    }
                } header: {
                    Text("Steps")
                }
            }
            .background(Color(red: 242/255, green: 241/255, blue: 247/255)) // prevents white from showing when keyboard dismissed
            //.background currently only works in darkmode
            .navigationTitle(vm.isNew ? "New workout" : "Edit workout")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                isTitleFocused = vm.isNew == true ? true : false
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(role: .cancel) {
                        dismiss()
                    } label: {
                        //Image(systemName: "xmark").tint(.red)
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
                        //Image(systemName: "checkmark")
                        Text("Save")
                    }
                    .disabled(!vm.workout.isValid)
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Menu {
                        Button {
                            withAnimation {
                                do {
                                    try vm.addStep("time")
                                } catch {
                                    print(error)
                                }
                            }
                        } label: {
                            Label("Time", systemImage: "stopwatch")
                        }
                        Button {
                            withAnimation {
                                do {
                                    try vm.addStep("distance")
                                } catch {
                                    print(error)
                                }
                            }
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
