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
    @FocusState var isTitleFocused: Bool
    @ObservedObject var workout: Workout
    
    @FetchRequest var steps: FetchedResults<Step>
    
    let isNew: Bool
    var provider: WorkoutsProvider
    private let context: NSManagedObjectContext
    
    init(provider: WorkoutsProvider, workout: Workout? = nil) {
        self.provider = provider
        self.context = provider.newContext
        
        if let workout, // is there a workout?
           let existingWorkoutCopy = provider.workoutExists(workout,
                                                            in: context) {  //does it exist in coreData?
            // if yes, load the object
            self.workout = existingWorkoutCopy
            self.isNew = false
            
        } else {
            // if no, create new workout
            self.workout = Workout(context: self.context)
            self.isNew = true
        }
        
        _steps = FetchRequest(
                entity: Step.entity(),
                sortDescriptors: [
                    NSSortDescriptor(keyPath: \Step.index, ascending: true)
                ],
                predicate: NSPredicate(format: "workout == %@", workout ?? "")
            )
        
        self.isTitleFocused = isNew
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Add Title", text: $workout.title)
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
                    if workout.stepArray.isEmpty {
                        HStack {
                            Spacer()
                            NoDataView(item: "Steps")
                            Spacer()
                        }
                        .listRowBackground(Color.clear)
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
            }
            .background(Color(red: 242/255, green: 241/255, blue: 247/255)) // prevents white from showing when keyboard dismissed, currently only works in darkmode
            .navigationTitle(/*vm.*/isNew ? "New workout" : "Edit workout")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if isNew { isTitleFocused = true }
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
                            try provider.persist(in: context)
                            dismiss()
                        } catch {
                            print(error)
                        }
                    } label: {
                        //Image(systemName: "xmark.circle.fill")
                        Text("Save")
                    }
                    //.disabled(!isValid)
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Menu {
                        Button {
                            withAnimation {
                                do {
                                    try addStep("time")
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
                                    try addStep("distance")
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
        EditView(provider: preview)
            .environment(\.managedObjectContext, preview.viewContext)
    }
}


private extension EditView {
    
    func addStep(_ type: String) throws {
        try provider.addStep(self.workout, in: self.context, type: type)
        try context.save()  // add save here if you want to remove the cancel button, delete objectwillchange.send() above
    }
    
    /*
    func addMocStep(_ type: String) throws {
        let newStep = Step(context: context)
        newStep.id = UUID()
        newStep.index = Int16(steps.count)
        newStep.magnitude = 800
        newStep.unit = "meters"
        newStep.pace = 315
        newStep.type = type
        newStep.workout = workout
        try context.save()  // this causes the list to update
    }
    */
    
}
