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
    @State var paceToggle: Bool = false
    @State var magnitudeToggle: Bool = false
    
    var body: some View {
        List {
            Section {   // select step type
                Picker("Type", selection: $step.type) {
                    ForEach(types, id: \.self) {
                        Text($0.capitalized)
                    }
                }
                
                LabeledContent {    // button for distance/time picker, based on type
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
                            Text("\(step.length) \(step.unit)")
                        case "time":
                            HStack {
                                step.hours>0 ? Text("\(step.hours)h") : nil
                                step.minutes>0 ? Text("\(step.minutes)m") : nil
                                step.seconds>0 ? Text("\(step.seconds)s") : nil
                            }
                        default:
                            Text("Unknown step type")
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
        .onChange(of: step.type) { newValue in
            switch step.type {
            case "distance":
                step.unit = "kilometers"
            case "time":
                step.unit = "minutes"
            default:
                step.unit = "Unknown unit"
                
            }
        }
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView(step: .constant(Step()))
    }
}
