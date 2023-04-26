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
                Image(systemName: "waveform.circle.fill")
                    .font(.title)
                    .padding(3)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(Color.accentColor)
            case "time":
                Image(systemName: "hourglass.circle.fill")
                    .font(.title)
                    .padding(3)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(Color.accentColor)
            default:
                Image(systemName: "xmark")
            }
            
            LabeledContent {
                Text("\(step.paceMinutes).\(step.paceSeconds) /km")
            } label: {
             switch step.type {
             case "distance":
                     Text("\(step.length) \(step.unit)")
                         //.font(.headline)
             case "time":
                 HStack {
                     step.hours>0 ? Text("\(step.hours)hr") : nil
                     step.minutes>0 ? Text("\(step.minutes)min") : nil
                     step.seconds>0 ? Text("\(step.seconds)sec") : nil
                 }
                 //.font(.headline)
             default:
                 Text("Unknown step type")
                }
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

