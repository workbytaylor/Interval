//
//  FormView.swift  // TODO: Rename to EditView? StepEditView? PickerView?
//  Interval
//
//  Created by Nilakshi Roy on 2023-03-20.
//

import SwiftUI

struct FormView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @Binding var step: Step
    @State var magnitudeButton: Bool = false
    @State var paceButton: Bool = false
    @State var pace: Bool = false
    
    let types: [String] = ["distance", "time"]
    
    var body: some View {
        List {
            Section {   // select step type
                Picker("Step Type", selection: $step.type) {
                    ForEach(types, id: \.self) {
                        Text($0.capitalized)
                    }
                }
                
                // Select step type
                LabeledContent {
                    Button {
                        withAnimation {
                            if paceButton == true {
                                paceButton = false
                            }
                            magnitudeButton.toggle()
                        }
                    } label: {
                        switch step.type {
                        case "distance":
                            Text("\(step.length) \(step.unit)")
                        case "time":
                            HStack {
                                step.hours>0 ? Text("\(step.hours)hr") : nil
                                step.minutes>0 ? Text("\(step.minutes)min") : nil
                                step.seconds>0 ? Text("\(step.seconds)sec") : nil
                            }
                        default:
                            Text("Unknown step type")
                        }
                    }
                    .buttonStyle(.bordered)
                    .foregroundColor(magnitudeButton == true ? .accentColor : .primary)
                } label: {
                    Text("Length")
                }
                if magnitudeButton == true {
                    switch step.type {
                    case "distance":
                        DistancePicker(step: $step)
                    case "time":
                        TimePicker(step: $step)
                    default:
                        Text("Invalid step type")
                    }
                }
                
                Toggle(isOn: $pace) {
                    Text("Pace Target")
                }
                
                
                if pace {
                    // select pace, if any?
                    LabeledContent {
                        Button {
                            withAnimation {
                                if magnitudeButton == true {
                                    magnitudeButton = false
                                }
                            }
                            paceButton.toggle()
                        } label: {
                            if step.paceSecondsKeep < 10 {
                                Text("\(step.paceMinutesKeep).0\(step.paceSecondsKeep) /km")
                            } else {
                                Text("\(step.paceMinutesKeep).\(step.paceSecondsKeep) /km")
                            }
                            
                            
                            
                        }
                        .buttonStyle(.bordered)
                        .foregroundColor(paceButton == true ? .accentColor : .primary)
                    } label: {
                        Text("Pace")
                    }
                    if paceButton == true {
                        PacePicker(step: $step)
                    }
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
