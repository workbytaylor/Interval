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
            case "time":
                Image(systemName: "stopwatch")
                    .font(.title2)
            default:
                Image(systemName: "xmark")
            }
            
            VStack(alignment: .leading) {
                // magnitude + unit
                switch step.type {
                case "distance":
                        Text("\(step.length) \(step.unit)")
                            .font(.headline)
                case "time":
                    HStack {
                        step.hours>0 ? Text("\(step.hours)hr") : nil
                        step.minutes>0 ? Text("\(step.minutes)min") : nil
                        step.seconds>0 ? Text("\(step.seconds)sec") : nil
                    }
                    .font(.headline)
                default:
                    Text("Unknown step type")
                }
                
                Text("\(step.paceMinutes).\(step.paceSeconds) /km")
                    .font(.subheadline)
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

