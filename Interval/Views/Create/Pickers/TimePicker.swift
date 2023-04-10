//
//  TimePickerView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-03-28.
//

import SwiftUI

struct TimePicker: View {
    
    @Binding var step: Step
     
    var hourRange = Int16(0)...Int16(24)
    var minuteRange = Int16(0)...Int16(60)
    var secondRange = Int16(0)...Int16(60)
    @State var magnitude: String = "0"
    
    var body: some View {
        HStack(spacing: .zero) {
            
            ZStack {
                Picker("Hours", selection: $step.hours) {
                    ForEach(hourRange, id: \.self) { hours in
                        Text(String(hours))
                    }
                }
                .pickerStyle(.wheel)
                Text("           h")   //10 spaces
                    .foregroundStyle(.secondary)
                    .monospacedDigit()
            }
            
            ZStack {
                Picker("Minutes", selection: $step.minutes) {
                    ForEach(minuteRange, id: \.self) { minutes in
                        Text(String(minutes))
                    }
                }
                .pickerStyle(.wheel)
                Text("          m")
                    .foregroundStyle(.secondary)
            }
            
            ZStack {
                Picker("Seconds", selection: $step.seconds) {
                    ForEach(secondRange, id: \.self) { seconds in
                        Text(String(seconds))
                    }
                }
                .pickerStyle(.wheel)
                Text("          s")
                    .foregroundStyle(.secondary)
            }
            
            
        }
    }
}
/*
struct TimePicker_Previews: PreviewProvider {
    static var previews: some View {
        TimePicker(step: .constant(Step()), magnitude: "0")
    }
}
*/
