//
//  NoDataView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-01-22.
//

import SwiftUI

struct NoDataView: View {
    let item: String
    
    var body: some View {
        Text("No \(item)")
        .font(.callout)
        .foregroundStyle(.secondary)
    }
}

struct NoDataView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NoDataView(item: "Workouts")
        }
    }
}
