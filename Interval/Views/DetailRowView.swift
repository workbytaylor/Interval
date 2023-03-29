//
//  DetailRowView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-01-28.
//

import SwiftUI

struct DetailRowView: View {
    var step: CoreDataStep
    
    var body: some View {
        HStack {
            //Text(String(step.index))
            Image(systemName: step.type == "distance" ? "lines.measurement.horizontal" : "stopwatch")
            
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
}


struct DetailRowView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            DetailRowView(step: CoreDataStep())
        }
    }
}

