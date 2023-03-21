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
    @State private var unit = "km"
    @State private var pace = 300
    
    @State private var selectedUnits = distanceUnits.allCases
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
                
                // set step pace (magnitude + unit)
                LabeledContent {
                    Button("\(magnitude) \(unit)") {    //TODO: does not update?
                        lengthToggle.toggle()
                    }
                } label: {
                    Text("Length")  // TODO: make dynamic later
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
                                Text(unit.rawValue)
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
