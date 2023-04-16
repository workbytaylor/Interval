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
                            paceButton = false
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
                
                // select pace, if any?
                // wrap in if statement when adding toggle
                LabeledContent {
                    Button {
                        withAnimation {
                            magnitudeButton = false
                            paceButton.toggle()
                        }
                    } label: {
                        if step.paceSeconds < 10 {
                            Text("\(step.paceMinutes).0\(step.paceSeconds) /km")
                        } else {
                            Text("\(step.paceMinutes).\(step.paceSeconds) /km")
                        }
                    }
                    .buttonStyle(.bordered)
                    .foregroundColor(paceButton == true ? .accentColor : .primary)
                } label: {
                    Text("Pace")
                }
                if paceButton {
                    PacePicker(step: $step)
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
