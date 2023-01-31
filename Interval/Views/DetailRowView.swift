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
            Text(String(step.index))
            Image(systemName: step.type == "distance" ? "lines.measurement.horizontal" : "stopwatch")
                //.font(.title3)
            
            VStack(alignment: .leading) {
                Text("\(step.magnitude) \(step.wrappedUnit)")
                
                let paceMinutes = step.pace/60
                let paceSeconds = step.pace%60
                
                Text("\(paceMinutes).\(paceSeconds) /km")
                    .font(.caption)
                    .foregroundStyle(.secondary)
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

