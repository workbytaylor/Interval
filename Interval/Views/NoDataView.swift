//
//  NoDataView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-01-22.
//

import SwiftUI

struct NoDataView: View {
    
    var body: some View {
        HStack {
            Spacer()
            Text("None")
            .font(.callout)
            .foregroundStyle(.secondary)
            Spacer()
        }
        .listRowBackground(Color.clear)
    }
}

struct NoDataView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NoDataView()
        }
    }
}
