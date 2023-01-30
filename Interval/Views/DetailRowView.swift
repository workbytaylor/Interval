//
//  DetailRowView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-01-28.
//

import SwiftUI

struct DetailRowView: View {
    
    var step: Step   // change to observedobject?
    
    var body: some View {
        HStack {
            Image(systemName: step.type == "distance" ? "lines.measurement.horizontal" : "stopwatch")
                //.frame(width: 40)
            
            VStack(alignment: .leading) {
                Text("\(step.magnitude) \(step.wrappedUnit)")
                    .font(.headline)
                
                let paceMinutes = step.pace/60
                let paceSeconds = step.pace%60
                
                Text("\(paceMinutes).\(paceSeconds) /km")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                /*
                Spacer()
                
                Menu {
                    Text("Take it easy! Don't rush, let your body relax.")
                } label: {
                    Image(systemName: "info")
                }
                */
            }
            
        }
    }
    
    private func paceMinutes(_ pace: Int) {
        
    }
    
    private func paceSeconds() {
        
    }
    
}


struct DetailRowView_Previews: PreviewProvider {
    static var previews: some View {
        
        List {
            DetailRowView(step: .preview())
        }
        
    }
}

