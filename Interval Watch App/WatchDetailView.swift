//
//  WatchDetailView.swift
//  Interval Watch App
//
//  Created by Nilakshi Roy on 2023-01-13.
//

import SwiftUI

struct WatchDetailView: View {
    var body: some View {
        List {
            Section {
                Text("40' Marathon Pace")
                    .font(.title3)
            }

            Section(header: Text("Steps")) {
                ForEach(1..<5) { workout in
                    HStack {
                        Image(systemName: "stopwatch")
                        Text("800m")
                    }
                    
                }
                Button {
                    // start run
                } label: {
                    Text("Start")
                }
                .listItemTint(.accentColor)
            }
        }
        .listStyle(.plain)
    }
}

struct WatchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WatchDetailView()
    }
}
