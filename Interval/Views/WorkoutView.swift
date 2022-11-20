//
//  WorkoutView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-14.
//

import SwiftUI

struct WorkoutView: View {
    
    var workout: Workout
    
    var body: some View {
        VStack(spacing: .zero) {
            List {
                ForEach(workout.steps, id: \.index) { step in
                    HStack(alignment: .firstTextBaseline) {
                        Image(systemName: step.type == "distance" ? "lines.measurement.horizontal" : "stopwatch")
                        
                        VStack(alignment: .leading) {
                            Text("\(step.target.magnitude) \(step.target.unit)")
                                .font(.headline)
                            Text(step.pace)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            Button {
                // start run
            } label: {
                Text("Start run")
                    .frame(maxWidth: .infinity)
                    .font(.headline)
                    .foregroundColor(.primary).colorInvert()
            }
            .buttonStyle(.borderedProminent)
            .tint(.primary)
            .padding([.horizontal, .bottom])
        }
        .navigationTitle("Workout details")
        .toolbar {
            ToolbarItem {
                Button {
                    // edit, add step?
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
        }
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            WorkoutView(workout: Workout.example)
        }
    }
}
