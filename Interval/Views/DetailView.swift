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
    
    @ObservedObject var workout: Workout
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
                    .environment(\.managedObjectContext, self.moc)
            }
        }
        /*.sheet(item: $workoutToEdit,
               onDismiss: {
            workoutToEdit = nil
        }, content: { workout in
            EditView(workout: workout)
        })*/
        .alert("Delete Workout", isPresented: $showDeleteAlert) {
            Button("Delete", role: .destructive) {
                //do {
                    // delete workout
                    // delete steps
                    dismiss()
                //} catch {
                  //  print(error)
                //}
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
            DetailView(workout: Workout())
        }
    }
}

