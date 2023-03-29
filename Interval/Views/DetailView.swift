//
//  DetailView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-26.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    
    @ObservedObject var workout: CoreDataWorkout
    @State private var showDeleteAlert: Bool = false
    @State private var showSheet: Bool = false
    
    var body: some View {
        List {
            Section {
                if workout.stepArray.isEmpty {
                    NoDataView()
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
                            showSheet.toggle()
                        } label: {
                            Label("Edit", systemImage: "square.and.pencil")
                        }
                    }
                } label: {
                    Image(systemName: "square.and.pencil")
                } primaryAction: {
                    showSheet.toggle()
                }
            }
        }
        .sheet(isPresented: $showSheet) {
            NavigationStack {
                EditView(workout: workout)
                    //.environment(\.managedObjectContext, moc) //I think sheets inherit the parent environment, no need to pass
            }
        }
        .alert("Delete Workout", isPresented: $showDeleteAlert) {
            Button("Delete", role: .destructive) {
                do {
                    try deleteSteps()   // deletes all steps in the workout to prevent stray steps
                    try deleteWorkout() // deletes the workout
                    try moc.save()
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
        NavigationStack {
            DetailView(workout: CoreDataWorkout())
        }
    }
}


extension DetailView {
    
    private func deleteSteps() throws {
        //moc.delete(steps.workout)
        // does not work, likely need fetchrequest to get steps for deletion
        // TODO: replace stepArray down the line with fetchrequest
    }
    
    private func deleteWorkout() throws {
        moc.delete(workout)
    }
    
    
    
}
