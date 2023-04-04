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
    @State var magnitude: String = "0"
    
    var body: some View {
        HStack(spacing: .zero) {
            /*
            Picker("Magnitude", selection: $step.magnitude) {
                ForEach(timeRange, id: \.self) { magnitude in
                    Text(String(magnitude))
                }
            }
            .pickerStyle(.wheel)
            */
            TextField("Magnitude", text: $magnitude)
                .frame(width: 100)
                .keyboardType(.numberPad)   // is this the right keyboard?
            
            Picker("Unit", selection: $step.unit) {
                ForEach(timeUnits, id: \.self) { unit in
                    Text(unit.capitalized)
                }
            }
            .labelsHidden()
        }
    }
}

struct TimePicker_Previews: PreviewProvider {
    static var previews: some View {
        TimePicker(step: .constant(Step()), magnitude: "0")
    }
}
