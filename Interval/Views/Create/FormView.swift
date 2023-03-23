//
//  FormView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-03-20.
//

import SwiftUI

struct FormView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var type = types.distance
    @State private var magnitude = 5
    @State private var unit = distanceUnits.km  // load with .onAppear?
    @State private var pace = 300
    
    @State private var selectedUnits: [String] = []
    @State private var lengthToggle: Bool = false
    @State private var magnitudeOptions = 1..<101
    
    enum types: String, CaseIterable {
        case distance = "Distance"
        case time = "Time"
    }
    enum distanceUnits: String, CaseIterable {
        case km = "Kilometers"
        case m = "Meters"
    }
    enum timeUnits: String, CaseIterable {
        case seconds = "Seconds"
        case minutes = "Minutes"
    }
    
    var body: some View {
        List {
            Section {
                // select step type
                Picker("Type", selection: $type) {
                    ForEach(types.allCases, id: \.self) { type in
                        Text(type.rawValue)
                    }
                }
                .onChange(of: type) { type in
                    switch type {
                    case .time:
                        selectedUnits = timeUnits.allCases.map {$0.rawValue}
                    case .distance:
                        selectedUnits = distanceUnits.allCases.map {$0.rawValue}
                    }
                }
                
                // set step pace (magnitude + unit)
                LabeledContent {
                    Button {
                        lengthToggle.toggle()
                    } label: {
                        Text("\(magnitude) \(unit.rawValue)")
                    }
                } label: {
                    Text(type.rawValue)
                }
                
                if lengthToggle == true {   // two wheel pickers: magnitude + unit
                    HStack {
                        Picker("Magnitude", selection: $magnitude) {
                            ForEach(magnitudeOptions, id: \.self) { magnitude in
                                Text(String(magnitude))
                            }
                        }
                        .pickerStyle(.wheel)
                        
                        
                        
                        
                        Picker("Unit", selection: $unit) {
                            ForEach(selectedUnits/*TODO: change selectedUnits on change of type*/, id: \.self) { unit in
                                Text(unit)
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                }
            }
        }
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}
