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
    @State private var paceToggle: Bool = true
    @State private var minutePace: Int = 3
    @State private var secondPace: Int = 0
    
    @State private var paceType = paceTypes.speed
    enum paceTypes: String, CaseIterable {
        case none = "Recovery"
        case speed = "Pace"
    }
    
    @State private var magnitude: String = "10"
    @State private var unit = Units.minutes
    enum Units: String, CaseIterable {
        case seconds = "Seconds"
        case minutes = "Minutes"
        case hours = "Hours"
        case kilometers = "Kilometers"
    }
    
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
                } footer: {
                   Text("")
                       .listRowInsets(EdgeInsets(top: -10, leading: 0, bottom: 0, trailing: 0))
               }
                
                Section {
                    HStack {
                        Toggle(isOn: $paceToggle.animation(.linear)) {
                            Label("Pace", systemImage: "stopwatch")
                        }
                    }
                    
                    if paceToggle == true {
                        
                        HStack(spacing: .zero) {
                            Picker("", selection: $minutePace) {
                                ForEach(2..<11) { minutePace in
                                    Text("\(minutePace) m")
                                }
                            }
                            .pickerStyle(.wheel)
                            Text(":")
                            Picker("", selection: $secondPace) {
                                ForEach(0..<12) { secondPace in  // add double zero (00)
                                    Text("\(secondPace*5) s")
                                }
                            }
                            .pickerStyle(.wheel)
                        }
                    }
                } header: { // required for spacing between sections
                    Text("")
                        .listRowInsets(EdgeInsets(top: -10, leading: 0, bottom: 0, trailing: 0))
                } footer: { // required for spacing between sections
                    Text("")
                        .listRowInsets(EdgeInsets(top: -10, leading: 0, bottom: 0, trailing: 0))
                }
            }
            .navigationTitle("Edit Step")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                        //save
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .environment(\.defaultMinListHeaderHeight, 1) // required for spacing between sections
        }
    }
}

struct EditStepView_Previews: PreviewProvider {
    static var previews: some View {
        EditStepView()
    }
}
