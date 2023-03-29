//
//  DistancePickerView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-03-28.
//

import SwiftUI

struct DistancePicker: View {
    
    @Binding var step: Step
    var distanceRange = Int16(1)...Int16(1000)
    var distanceUnits: [String] = ["kilometers", "meters"]
    
    var body: some View {
        HStack(spacing: .zero) {
            Picker("Magnitude", selection: $step.magnitude) {
                ForEach(distanceRange, id: \.self) { magnitude in
                    Text(String(magnitude))
                }
            }
            .pickerStyle(.wheel)
            Picker("Unit", selection: $step.unit) {
                ForEach(distanceUnits, id: \.self) { unit in
                    Text(unit)
                }
            }
            .pickerStyle(.wheel)
        }
    }
}

struct DistancePicker_Previews: PreviewProvider {
    static var previews: some View {
        DistancePicker(step: .constant(Step()))
    }
}
