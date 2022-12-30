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
    
    @State private var toggle: Bool = false
    
    @State private var minutePace: Int = 3
    @State private var secondPace: Int = 0
    
    @State private var type = Types.distance
    enum Types: String, CaseIterable {
        case distance = "Distance"
        case time = "Time"
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
            VStack(alignment: .center, spacing: .zero) {
                
                // TODO: Focus state for bottom sheet? Tapping title field should dismiss sheet
                
                HStack {
                    Text("Type")
                    Spacer()
                    Picker("Type", selection: $type) {
                        ForEach(Types.allCases, id: \.self) { type in
                            Text(type.rawValue)
                        }
                    }
                }
                Divider()
                    .padding(.vertical, 10)
                HStack {
                    Text(type.rawValue)
                    Spacer()
                    TextField("0", text: $magnitude)
                    // text height needs to be bigger to match pickers
                        .multilineTextAlignment(.center)
                        .frame(width: 40)
                        .padding(.horizontal).padding(.vertical, 4) // TODO: Fix this syntax
                        .background(Color(red: 244/255, green: 244/255, blue: 245/255))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        //.padding(.vertical)
                    
                    Picker("Unit", selection: $unit) {
                        ForEach(Units.allCases, id: \.self) { unit in
                            Text(unit.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                }
                Divider()
                    .padding(.vertical, 10)
                
                
                Toggle("Pace", isOn: $toggle)
                
                if toggle == true {
                    HStack(spacing: .zero) {
                        Picker("", selection: $minutePace) {
                            ForEach(2..<11) { num in
                                Text(String(num))
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 80)
                        Text(":")
                        Picker("", selection: $secondPace) {
                            ForEach(0..<12) {   // add double zero (00)
                                Text("\($0*5)")
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 80)
                        
                        Text("/ km")
                    }
                    .clipShape(Rectangle())
                }
                //Spacer()
            }
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            //.padding()
    }
}

struct EditStepView_Previews: PreviewProvider {
    static var previews: some View {
        EditStepView()
    }
}
