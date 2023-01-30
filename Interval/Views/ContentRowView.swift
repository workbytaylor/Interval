//
//  ContentRowView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-01-20.
//

import SwiftUI

struct ContentRowView: View {
    @Environment(\.managedObjectContext) private var moc
    @ObservedObject var workout: Workout
    
    var body: some View {
        LabeledContent {
            Text("\(workout.stepArray.count) steps")
        } label: {
            Text(workout.title)
        }
        
        // Past design
        /*
        HStack {
            Text(workout.title)
                .font(.headline)
            Text("\(workout.stepArray.count) steps")
                .foregroundStyle(.secondary)
                .font(.subheadline)
        }
         */
    }
}


struct ContentRowView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ContentRowView(workout: .preview())
        }
    }
}
