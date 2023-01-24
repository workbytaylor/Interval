//
//  NoDataView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-01-22.
//

import SwiftUI

struct NoDataView: View {
    
    var item: String
    
    var body: some View {
        HStack {
            Text("Tap")
            Image(systemName: "plus")
            Text("to add your first \(item)")
        }
        .font(.callout)
        .foregroundStyle(.secondary)
    }
}

struct NoDataView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NoDataView(item: "workout")
        }
    }
}
