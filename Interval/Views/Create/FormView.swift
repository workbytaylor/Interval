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
    @State var magnitudeToggle: Bool = false
    
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
                    // tap to reveal picker
                    Button {
                        withAnimation {
                            if paceToggle == true {
                                paceToggle = false
                            }
                            magnitudeToggle.toggle()
                        }
                    } label: {
                        switch step.type {
                        case "distance":
                            Text("\(step.magnitude) \(step.unit)")
                        case "time":
                            let hours = step.magnitude/3600
                            let minutes = (step.magnitude%3600)/60
                            let seconds = (step.magnitude%3600)%60
                            
                            Text("\(hours)h \(minutes)m \(seconds)s")
                        default:
                            Text("Unknown Error")
                        }
                    }
                    .buttonStyle(.bordered)
                    .foregroundColor(magnitudeToggle == true ? .accentColor : .primary)
                } label: {
                    Text("Length")
                }
                if magnitudeToggle == true {
                    switch step.type {
                    case "distance":
                        DistancePicker(step: $step)
                    case "time":
                        TimePicker(step: $step)
                    default:
                        Text("Invalid step type")
                    }
                }
                
                LabeledContent {
                    Button {
                        withAnimation {
                            if magnitudeToggle == true {
                                magnitudeToggle = false
                            }
                        }
                        paceToggle.toggle()
                    } label: {
                        Text("Pace")
                    }
                    .buttonStyle(.bordered)
                    .foregroundColor(paceToggle == true ? .accentColor : .primary)
                } label: {
                    Text("Pace")
                }
                if paceToggle == true {
                    PacePicker()
                }
                
                
                
            }
        }
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView(step: .constant(Step()))
    }
}
