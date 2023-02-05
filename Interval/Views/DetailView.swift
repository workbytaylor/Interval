//
//  DetailView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-26.
//

import SwiftUI

struct DetailView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var workout: Workout
    var provider: WorkoutsProvider
    @State private var showDeleteAlert: Bool = false
    @State private var workoutToEdit: Workout?
    
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.index, order: .forward)],
        predicate: NSPredicate(format: "workout == %@", workout)
    ) var fetchedSteps: FetchedResults<Step>
    
    
    
    var body: some View {
        List {
            Section {
                ForEach(fetchedSteps) { step in
                    Text(String(step.index))
                }
            } header: {
                Text("Fetched Steps")
            }
            
            
            
            /*
            Section {
                Text("The purpose of this workout is to...")
            } header: {
                Text("Notes")
            }
            */
            
            Section {
                if workout.stepArray.isEmpty {
                    HStack {
                        Spacer()
                        Text("No steps")
                        Spacer()
                    }
                    .foregroundStyle(.secondary)
                    .listRowBackground(Color.clear)
                } else {
                    ForEach(workout.stepArray) { step in
                        DetailRowView(step: step)
                    }
                }
            } header: {
                Text("Steps")
            }
            
        }
        .listStyle(.automatic)
        .navigationBarTitle(workout.title)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Menu {
                    Section {
                        Button(role: .destructive) {
                            showDeleteAlert = true
                        } label: {
                            Label("Delete Workout", systemImage: "trash")
                        }
                    }
                    Section {
                        Button {
                            workoutToEdit = workout
                        } label: {
                            Label("Edit", systemImage: "square.and.pencil")
                        }
                    }
                } label: {
                    Image(systemName: "square.and.pencil")
                } primaryAction: {
                    workoutToEdit = workout
                }
                
            }
        }
        .sheet(item: $workoutToEdit,
               onDismiss: {
            workoutToEdit = nil
        }, content: { workout in
            EditView(vm: .init(provider: provider,
                              workout: workout))
        })
        .alert("Delete Workout", isPresented: $showDeleteAlert) {
            Button("Delete", role: .destructive) {
                do {
                    try provider.deleteWorkout(workout, in: provider.newContext)
                    dismiss()
                } catch {
                    print(error)
                }
            }
            Button("Cancel", role: .cancel) {  }
        } message: {
            Text("Are you sure?")
        }
    }
}


struct DetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        let previewProvider = WorkoutsProvider.shared
        NavigationStack {
            DetailView(workout: .preview(context: previewProvider.viewContext), provider: previewProvider)
            //no data because there are no steps, yet
        }
    }
}

