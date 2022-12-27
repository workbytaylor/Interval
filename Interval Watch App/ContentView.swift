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
            
            Section {
                VStack(alignment: .leading) {
                    // key info on run
                    
                    Text("40' Marathon Pace")
                        .font(.title3)
                    Text("8km | 38m")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
                
                
            }
            
 
            Section(header: Text("Steps")) {
                
                ForEach(1..<5) { workout in
                    NavigationLink {
                        //
                    } label: {
                        HStack {
                            Image(systemName: "stopwatch")
                            Text("800m")
                        }
                        .foregroundStyle(.secondary)
                    }
                }
                Button {
                    // start run
                } label: {
                    Text("Start")
                        .font(.headline)
                        .foregroundColor(.black)
                }
                .listItemTint(.yellow)
            }
            
        }
        .listStyle(.plain)
        .navigationTitle {
            HStack {
                Text("Today's Run")
                Spacer()
            }
            
            
        }   //Strava uses this here
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
