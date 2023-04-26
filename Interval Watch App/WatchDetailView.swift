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
        .navigationTitle("40' Marathon Pace")
    }
}

struct WatchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WatchDetailView()
    }
}
