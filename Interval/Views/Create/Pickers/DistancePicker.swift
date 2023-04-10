//
//  DistancePickerView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-03-28.
//

import SwiftUI

struct DistancePicker: View {
    
    @ObservedObject var step: Step
    var hundredsRange = Int16(0)...Int16(100)
    var tensRange = Int16(0)...Int16(99)
    var distanceUnits: [String] = ["kilometers", "meters"]
    
    @State var hundreds: Int16 = 0
    @State var tens: Int16 = 0
    //@State var unit: String = "Unknown unit"
    
    var body: some View {
        HStack(spacing: .zero) {
            
            Picker("Magnitude", selection: $hundreds) {
                ForEach(hundredsRange, id: \.self) {
                    Text(String($0))
                }
            }
            .pickerStyle(.wheel)
            
            Picker("Magnitude", selection: $tens) {
                ForEach(tensRange, id: \.self) {
                    $0 < 10 ? Text("0\($0)") : Text(String($0))
                }
            }
            .pickerStyle(.wheel)
            
            Picker("Unit", selection: $step.unit) {
                ForEach(distanceUnits, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.wheel)
        }.onAppear {
            hundreds = step.magnitude/100
            tens = step.magnitude%100
        }
        .onChange(of: [hundreds, tens]) { newValue in
            step.magnitude = Int16(hundreds*100+tens)
        }
        .onDisappear {
            //TODO: check sole earlier project
        }
    }
}

struct DistancePicker_Previews: PreviewProvider {
    static var previews: some View {
        DistancePicker(step: Step())
    }
}
