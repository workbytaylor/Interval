//
//  TimePickerView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-03-28.
//

import SwiftUI

struct TimePicker: View {
    
    @Binding var step: Step
    var timeRange = Int16(1)...Int16(1000)
    var timeUnits: [String] = ["hours", "minutes", "seconds"]
    
    
    var body: some View {
        HStack(spacing: .zero) {
            Picker("Magnitude", selection: $step.magnitude) {
                ForEach(timeRange, id: \.self) { magnitude in
                    Text(String(magnitude))
                }
            }
            
            .pickerStyle(.wheel)
            Picker("Unit", selection: $step.unit) {
                ForEach(timeUnits, id: \.self) { unit in
                    Text(unit)
                }
            }
            .pickerStyle(.wheel)
        }
    }
}

struct TimePicker_Previews: PreviewProvider {
    static var previews: some View {
        TimePicker(step: .constant(Step()))
    }
}
