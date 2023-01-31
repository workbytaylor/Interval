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
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Add Title", text: $vm.workout.title)
                        .font(.system(.title2, design: .default, weight: .semibold))
                        .autocorrectionDisabled(false)
                        .autocapitalization(.sentences)
                        .overlay(alignment: .trailing) {
                            if vm.workout.title != "" {
                                Button {
                                    vm.eraseTitle()
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                }
                                .symbolRenderingMode(.hierarchical)
                                .foregroundStyle(.secondary)
                            }
                        }
                        .focused($isTitleFocused)
                    
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
                            /*
                            .swipeActions {
                                Button(role: .destructive) {
                                    do {
                                        try vm.deleteStep(step)
                                        
                                    } catch {
                                        print(error)
                                    }
                                         
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                        .tint(.red)
                                }
                            }
                             */
                            .deleteDisabled(vm.workout.stepArray.count < 2)
                        }
                        .onDelete(perform: vm.onDeleteStep)
                    }
                } header: {
                    Text("Steps")
                }
            }
            .background(Color(red: 242/255, green: 241/255, blue: 247/255)) // prevents white from showing when keyboard dismissed
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
                        //Image(systemName: "xmark.circle.fill")
                    }
                    .controlSize(.small)
                    .buttonStyle(.bordered)
                    //.symbolRenderingMode(.hierarchical)
                    //.foregroundStyle(.secondary)
                    .disabled(!vm.workout.isValid)
                }
                ToolbarItem(placement: .bottomBar) {
                    
                    
                    Menu {
                        Button {
                            withAnimation {
                                vm.addStep(type: "time")
                            }
                        } label: {
                            Label("Time", systemImage: "stopwatch")
                        }
                        Button {
                            withAnimation {
                                vm.addStep(type: "distance")
                            }
                        } label: {
                            Label("Distance", systemImage: "lines.measurement.horizontal")
                        }
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("Add Step")
                        }
                    }/* primaryAction: {
                        withAnimation {
                            vm.addStep(type: "distance")
                        }
                    }*/
                    
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
