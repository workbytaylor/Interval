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
                .font(.title2)
            
            VStack(alignment: .leading) {
                Text("\(step.magnitude) \(step.wrappedUnit)")
                
                let paceMinutes = step.pace/60
                let paceSeconds = step.pace%60
                
                
                Text("\(paceMinutes).\(paceSeconds) /km")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Menu {
                Text("Step notes here")
            } label: {
                Image(systemName: "ellipsis")
                    
            }
            .disabled(.random())
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

