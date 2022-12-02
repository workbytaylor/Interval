//
//  DetailView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-26.
//

import SwiftUI

struct DetailView: View {
    
    @ObservedObject var workout: Workout
    @EnvironmentObject var workouts: Workouts
    @Environment(\.dismiss) var dismiss
    @Environment(\.editMode) private var editMode   // starting to think buttons are better than delete
    
    @State private var showDeleteAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(workout.steps, id: \.index) { step in
                    HStack {
                        Image(systemName: step.type == "distance" ? "lines.measurement.horizontal" : "stopwatch")
                            .frame(width: 40)
                        //Text(String(step.index))
                        VStack(alignment: .leading) {
                            Text(String(step.target.magnitude))+Text(" \(step.target.unit)")
                                .foregroundColor(.primary)
                            Text(step.pace)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                //.onDelete(perform: deleteStep)
                .onMove(perform: nil)
            }
            .navigationTitle(workout.title)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if editMode?.wrappedValue.isEditing == true {
                        Button { showDeleteAlert.toggle() } label: { Image(systemName: "trash").foregroundColor(.red) }
                        
                        Button { addStep() } label: { Image(systemName: "plus") }
                    }
                    
                    EditButton()
                }
            }
            .alert("Delete workout", isPresented: $showDeleteAlert) {
                Button("Delete", role: .destructive, action: deleteWorkout)
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Are you sure?")
            }
            
        }
    }
    
    private func addStep() {    // consider using same funcs as AddView
        let newStep: Step = Step()
        newStep.index = workout.steps.count+1
        workout.steps.append(newStep)
    }
    
    private func deleteStep(at offsets: IndexSet) {
        workout.steps.remove(atOffsets: offsets)
    }
    
    private func deleteWorkout() {
        workouts.deleteWorkout(at: IndexSet())
        //try? moc.save()
        dismiss()   //returns to ContentView after delete
    }
    
    
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(workout: Workout())  // likely need to create sample data in Workout.swift
    }
}
