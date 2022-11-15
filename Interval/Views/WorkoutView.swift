//
//  WorkoutView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-14.
//

import SwiftUI

struct WorkoutView: View {
    
    //var workout: Workout
    
    var body: some View {
        VStack(spacing: .zero) {
            List {
                // steps
                Text("Step 1")
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
            WorkoutView()
        }
    }
}
