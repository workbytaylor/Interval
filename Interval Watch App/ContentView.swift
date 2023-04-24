//
//  ContentView.swift
//  Interval Watch App
//
//  Created by Nilakshi Roy on 2022-11-13.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
            ForEach(1..<5, id: \.self) { item in
                NavigationLink {
                    WatchDetailView()
                } label: {
                    Text("Item \(item)")
                }
            }
            
        }
        .navigationTitle("Workouts")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContentView()
        }
    }
}
