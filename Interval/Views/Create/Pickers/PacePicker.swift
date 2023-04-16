//
//  PacePicker.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-04-06.
//

import SwiftUI

struct PacePicker: View {
    
    @Binding var step: Step
    @State var minuteRange = Int16(0)...Int16(10)
    @State var secondRange = Array(stride(from: Int16(0), through: Int16(55), by: Int16.Stride(Int16(5))))
    
    var body: some View {
        
        HStack {
            ZStack {
                // text behind picker?
                Text("            min") // 12 spaces
                Picker("Minutes", selection: $step.paceMinutesKeep) {
                    ForEach(minuteRange, id: \.self) { minute in
                        Text(String(minute))
                    }
                }
                .pickerStyle(.wheel)
                
            }
            
            ZStack {
                Text("              sec") // 14 spaces
                Picker("Seconds", selection: $step.paceSecondsKeep) {
                    ForEach(secondRange, id: \.self) { second in
                        if second < 10 {
                            Text("0\(second)")
                        } else {
                            Text(String(second))
                        }
                    }
                }
                .pickerStyle(.wheel)
                
            }
            
            Text("/km")
        }
    }
}

struct PacePicker_Previews: PreviewProvider {
    static var previews: some View {
        PacePicker(step: .constant(Step()))
    }
}
