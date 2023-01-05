//
//  EditStepView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-12-29.
//

import SwiftUI

struct EditStepView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var lengthToggle: Bool = false
    @State private var paceToggle: Bool = false
    
    @State private var magnitude: Int = 5
    @State private var unit = Units.minutes
    enum Units: String, CaseIterable {
        case seconds = "Seconds"
        case minutes = "Minutes"
        case hours = "Hours"
        case kilometers = "Kilometers"
    }
    
    @State private var minutePace: Int = 5
    @State private var secondPace: Int = 0
    
    @State private var paceMinuteOptions = 1...99
    @State private var paceSecondOptions = Array(stride(from: 0, to: 55, by: 5))
    
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Label("Length", systemImage: "arrow.left.and.right")
                        Spacer()
                        Button {
                            withAnimation {
                                lengthToggle.toggle()
                            }
                        } label: {
                            Text("\(magnitude) \(unit.rawValue)")
                        }
                        .buttonStyle(.bordered)
                        .foregroundColor(lengthToggle == true ? .accentColor : .primary)
                    }
                    
                    if lengthToggle == true {
                        HStack {
                            Picker("Magnitude", selection: $magnitude) {
                                ForEach(1..<101, id: \.self) { magnitude in
                                    Text(String(magnitude))
                                }
                            }
                            .pickerStyle(.wheel)
                            Picker("Unit", selection: $unit) {
                                ForEach(Units.allCases, id: \.self) { unit in
                                    Text(unit.rawValue)
                                }
                            }
                            .pickerStyle(.wheel)
                        }
                    }
                } header: {
                    //Text("Length")
                }
                /* footer: {
                   Text("")
                       .listRowInsets(EdgeInsets(top: -10, leading: 0, bottom: 0, trailing: 0))
               }*/
                
                Section {
                    HStack {
                        Label("Pace", systemImage: "stopwatch")
                        Spacer()
                        Button {
                            withAnimation {
                                paceToggle.toggle()
                            }
                        } label: {
                            Text("\(minutePace).")+Text(secondPace < 10 ? "0" :  "")+Text("\(secondPace)")+Text(" /km")
                        }
                        .buttonStyle(.bordered)
                        .foregroundColor(paceToggle == true ? .accentColor : .primary)
                    }
                    
                    if paceToggle == true {
                        HStack(spacing: .zero) {
                            Picker("", selection: $minutePace) {
                                ForEach(paceMinuteOptions, id: \.self) { minute in
                                    Text("\(minute) m")
                                }
                            }
                            .pickerStyle(.wheel)
                            Text(":")
                            Picker("", selection: $secondPace) {
                                ForEach(paceSecondOptions, id: \.self) { secondPace in  // add double zero (00)
                                    Text("\(secondPace) s")
                                }
                            }
                            .pickerStyle(.wheel)
                        }
                    }
                } header: {
                    //Text("Pace")
                }/* header: { // required for spacing between sections
                    Text("")
                        .listRowInsets(EdgeInsets(top: -10, leading: 0, bottom: 0, trailing: 0))
                } footer: { // required for spacing between sections
                    Text("")
                        .listRowInsets(EdgeInsets(top: -10, leading: 0, bottom: 0, trailing: 0))
                }*/
            }
            .navigationTitle("Edit Step")
            .navigationBarTitleDisplayMode(.inline)
            //.environment(\.defaultMinListHeaderHeight, 1) // required for spacing between sections
        }
    }
}

struct EditStepView_Previews: PreviewProvider {
    static var previews: some View {
        EditStepView()
    }
}
