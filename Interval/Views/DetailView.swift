//
//  DetailView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-26.
//

import SwiftUI

struct DetailView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var moc    // added this to delete the workout
    var workout: Workout
    @State private var showDeleteAlert: Bool = false
    @State var showEditView: Bool = false
    
    var body: some View {
        //ZStack {
            List {
                ForEach(workout.stepArray) { step in
                    HStack {
                        Image(systemName: step.type == "distance" ? "lines.measurement.horizontal" : "stopwatch")
                            .frame(width: 40)
                         VStack(alignment: .leading) {
                             Text("\(step.magnitude)")+Text("\(step.wrappedUnit)")
                            Text("Pace")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
        //}
        .navigationBarTitle(workout.title)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Menu {
                    Button(role: .destructive) {
                        showDeleteAlert = true
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                    
                    Divider()
                    
                    Button {
                        showEditView.toggle()
                    } label: {
                        Label("Edit", systemImage: "square.and.pencil")
                    }
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
        }
        .sheet(isPresented: $showEditView) {
            EditView(vm: .init(provider: .shared)/*workout: workout*/)
        }
        .alert("Delete Workout", isPresented: $showDeleteAlert) {
            Button("Delete", role: .destructive) {
                do {
                    try deleteWorkout()
                } catch {
                    print(error)    // handles the erorr from 'throws' in function below
                }
            }
            Button("Cancel", role: .cancel) {  }
        } message: {
            Text("Are you sure?")
        }
    }
}

private extension DetailView {
    
    func deleteWorkout() throws {
        moc.delete(workout)
        Task(priority: .background) {   // handles save in the background
            try await moc.perform {
                try moc.save()
            }
        }
        dismiss()
    }
    
}




struct DetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        DetailView(workout: .preview())
        //no data because there are no steps, yet
    }
}

