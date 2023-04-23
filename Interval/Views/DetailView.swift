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
    //@State private var showSheet: Bool = false
    
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
                    Button(role: .destructive) {
                        showDeleteAlert = true
                    } label: {
                        Label("Delete Workout", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
        }
        /*
        .sheet(isPresented: $showSheet) {
            NavigationStack {
                EditView(workout: workout)
                    //.environment(\.managedObjectContext, moc)
            }
        }
         */
        .alert("Delete Workout", isPresented: $showDeleteAlert) {
            Button("Yup", role: .destructive) {
                do {
                    try deleteSteps()   // deletes all steps in the workout to prevent stray steps
                    try deleteWorkout() // deletes the workout
                    try moc.save()
                    dismiss()
                } catch {
                    print(error)
                }
            }
            Button("Nope", role: .cancel) {  }
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
