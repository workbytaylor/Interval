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
    
    @Binding var step: Step
    
    var types: [String] = ["distance", "time"]
    var distanceUnits: [String] = ["kilometers", "meters"]
    var timeUnits: [String] = ["hours", "minutes", "seconds"]
    var magnitudeRange = Int16(1)...Int16(1000)
    
    @State var magnitude: Int16 = 10
    
    //@State var lengthPicker: Bool = false
    @State var paceToggle: Bool = false
    @State var lengthToggle: Bool = false
    
    var body: some View {
        List {
            Section {
                // select step type
                Picker("Type", selection: $step.type) {
                    ForEach(types, id: \.self) {
                        Text($0.capitalized)
                    }
                }
                
                
                LabeledContent {
                    Button {
                        withAnimation {
                            if paceToggle == true {
                                paceToggle = false
                            }
                            lengthToggle.toggle()
                        }
                    } label: {
                        Text("\(step.magnitude) \(step.unit)")
                    }
                    .buttonStyle(.bordered)
                    .foregroundColor(lengthToggle == true ? .accentColor : .primary)
                } label: {
                    Text("Length")
                }
                if lengthToggle == true {
                    switch step.type {
                    case "distance":
                        DistancePicker(step: $step)
                    case "time":
                        TimePicker(step: $step)
                    default:
                        Text("Invalid step type")
                    }
                }
                
                
                // length picker
                // repeat button
                //
                
            }
            
            //TimePicker(step: $step)
        }
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView(step: .constant(Step()))
    }
}
