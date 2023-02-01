//
//  EditStepView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-12-29.
//

import SwiftUI

struct EditStepView: View {
    
    @Environment(\.dismiss) var dismiss

    @State private var stepType = stepTypes.distance
    enum stepTypes: String, CaseIterable {
        case distance = "Distance"
        case time = "Time"
    }
    
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
    
    @State private var paceMinuteOptions = 1...20
    @State private var paceSecondOptions = Array(stride(from: 0, to: 60, by: 5))
    
    //@State var notes: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    
                    HStack {
                        Picker("Type", selection: $stepType) {
                            ForEach(stepTypes.allCases, id: \.self) { type in
                                Text(type.rawValue)
                            }
                        }
                        .labelsHidden()
                        .padding(.leading, -14)
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
                    
                    if lengthToggle == !true {
                        HStack(spacing: .zero) {
                            Picker("Unit", selection: $unitType) {
                                ForEach(stepTypes.allCases, id: \.self) { type in
                                    Text(type.rawValue)
                                }
                            }
                            .pickerStyle(.wheel)
                            Text(":")
                            Picker("Type", selection: $stepType) {
                                ForEach(stepTypes.allCases, id: \.self) { type in
                                    Text(type.rawValue)
                                }
                            }
                            .pickerStyle(.wheel)
                        }
                        
                        
                        
                        
                        
                    }
                    
                    
                    /*
                    Picker("Type", selection: $stepType) {
                        ForEach(stepTypes.allCases, id: \.self) { type in
                            Text(type.rawValue)
                        }
                    }
                     */
                     
                    HStack {
                        Text("\(stepType.rawValue)")    // Duration / distance
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
                     
                    
                //}
                
                //Section {
                    HStack {
                        Text("Pace")
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
                }
                
                
                /*
                 // Notes for each step - necessary?
                TextField("Notes", text: $notes, axis: .vertical)
                    .lineLimit(3, reservesSpace: true)
                    .onChange(of: notes) { characters in
                        let maxCount = 80
                            if characters.count > maxCount {
                                self.notes = String(characters.prefix(maxCount))
                            }
                        }
                */
            }
            .navigationTitle("Edit Step")
            .navigationBarTitleDisplayMode(.inline)
            /*
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        //vm.deleteStep(step)
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "trash")
                            Text("Delete Step")
                        }
                        .tint(.red)
                    }
                }
            }
             */
        }
    }
}

struct EditStepView_Previews: PreviewProvider {
    static var previews: some View {
        EditStepView()
    }
}
