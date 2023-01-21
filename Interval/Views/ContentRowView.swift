//
//  ContentRowView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-01-20.
//

import SwiftUI

struct ContentRowView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text(/*workout.wrappedTitle*/"Title")
                .font(.headline)
            //Text("\(workout.stepArray.count) steps")
            Text("6 steps")
                .foregroundStyle(.secondary)
                .font(.subheadline)
        }
    }
}

struct ContentRowView_Previews: PreviewProvider {
    static var previews: some View {
        ContentRowView()
    }
}
