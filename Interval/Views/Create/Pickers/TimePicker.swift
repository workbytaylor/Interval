//
//  TimePickerView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-03-28.
//

import SwiftUI

struct TimePicker: View {
    
    @ObservedObject var step: Step
    
    @State var hours: Int16 = 0
    @State var minutes: Int16 = 0
    @State var seconds: Int16 = 0
    
    var hourRange = Int16(0)...Int16(24)
    var minuteRange = Int16(0)...Int16(60)
    var secondRange = Int16(0)...Int16(60)
    @State var magnitude: String = "0"
    
    var body: some View {
        HStack(spacing: .zero) {
            
            ZStack {
                Picker("Hours", selection: $hours) {
                    ForEach(hourRange, id: \.self) { hours in
                        Text(String(hours))
                    }
                }
                .pickerStyle(.wheel)
                Text("         h")   //8 spaces
                    .foregroundStyle(.secondary)
            }
            
            ZStack {
                Picker("Minutes", selection: $minutes) {
                    ForEach(minuteRange, id: \.self) { minutes in
                        Text(String(minutes))
                    }
                }
                .pickerStyle(.wheel)
                Text("        m")
            }//.monospacedDigit()   // an attempt to make spacing regular
            
            ZStack {
                Picker("Seconds", selection: $seconds) {
                    ForEach(secondRange, id: \.self) { seconds in
                        Text(String(seconds))
                    }
                }
                .pickerStyle(.wheel)
                Text("        s")
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
