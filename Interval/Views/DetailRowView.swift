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
            
            switch step.type {
            case "distance":
                Image(systemName: "lines.measurement.horizontal")
                    .font(.title2)
                VStack(alignment: .leading) {
                    Text("\(step.length) \(step.unit)")
                    Text("\(step.paceMinutes).\(step.paceSeconds) /km")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            case "time":
                Image(systemName: "stopwatch")
                    .font(.title2)
                VStack(alignment: .leading) {
                    HStack {
                        let hours = step.length/3600
                        let minutes = (step.length%3600)/60
                        let seconds = (step.length%3600)%60
                        
                        hours > 0 ? Text("\(hours)h") : nil
                        minutes > 0 ? Text("\(minutes)m") : nil
                        seconds > 0 ? Text("\(seconds)s") : nil
                    }
                    Text("\(step.paceMinutes).\(step.paceSeconds) /km")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            default:
                Text("?")
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

