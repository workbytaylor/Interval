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
    @ObservedObject var workout: Workout
    @FetchRequest var steps: FetchedResults<Step>
    //private let context: NSManagedObjectContext
    
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
                    if workout.stepArray.isEmpty {
                        NoDataView(item: "Steps")
                        /*
                        HStack {
                            Spacer()
                            NoDataView(item: "Steps")
                            Spacer()
                        }
                        .listRowBackground(Color.clear)
                         */
                    } else {
                        
                        ForEach(steps) { step in
                            NavigationLink {
                                EditStepView()
                            } label: {
                                DetailRowView(step: step)
                            }
                            .deleteDisabled(workout.stepArray.count < 2)
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
                        
                        //.onDelete(perform: deleteStepWithOffsets)
                    }
                } header: {
                    Text("Steps")
                }
                
                Section {
                    Button {
                        withAnimation {
                            // add step
                        }
                    } label: {
                        Label("Add Step", systemImage: "plus")
                    }
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
                        // save
                        dismiss()
                    } label: {
                        //Image(systemName: "xmark.circle.fill")
                        Text("Save")
                    }
                }
                /*
                ToolbarItem(placement: .bottomBar) {
                    Menu {
                        Button {
                            withAnimation {
                                // add time step
                            }
                        } label: {
                            Label("Time", systemImage: "stopwatch")
                        }
                        Button {
                            withAnimation {
                                // add distance step
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
                 */
            }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(workout: Workout())
    }
}
