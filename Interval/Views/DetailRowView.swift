//
//  DetailRowView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-01-28.
//

import SwiftUI

struct DetailRowView: View {
    
    @ObservedObject var step: Step   // change to observedobject?
    
    var body: some View {
        HStack {
            Image(systemName: step.type == "distance" ? "lines.measurement.horizontal" : "stopwatch")
                .frame(width: 40)
            Text("\(step.magnitude)")+Text(" \(step.wrappedUnit)")
            Text("5.15 /km")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}

/*
struct DetailRowView_Previews: PreviewProvider {
    static var previews: some View {
        DetailRowView(step: .preview())
    }
}
*/
