//
//  NoWorkoutsView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-01-22.
//

import SwiftUI

struct NoWorkoutsView: View {
    var body: some View {
        HStack {
            Text("Tap")
            Image(systemName: "plus")
            Text("to create your first workout")
        }
        .font(.callout)
        .foregroundStyle(.secondary)
    }
}

struct NoWorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        NoWorkoutsView()
    }
}
