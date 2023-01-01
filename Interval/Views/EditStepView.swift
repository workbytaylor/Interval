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
    
    @State private var showingPopover: Bool = false
    
    //@State private var toggleDistance: Bool = false
    
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
        ScrollView {
            VStack(alignment: .center, spacing: .zero) {
                
                // TODO: Focus state for bottom sheet? Tapping title field should dismiss sheet
                
                HStack {
                    Spacer()
                    Button {
                        // toggle showEditStepView
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                    }
                    .foregroundStyle(.secondary)
                }
                
                .overlay {
                    Text("Edit Step")
                        .font(.headline)
                }
                .padding(.bottom)
                
                
                HStack {
                    Text("Length")
                    Spacer()
                    Picker("Magnitude", selection: $magnitude) {
                        ForEach(1..<101) { magnitude in
                            Text(String(magnitude))
                        }
                    }
                    .pickerStyle(.menu)
                    Picker("Unit", selection: $unit) {
                        ForEach(Units.allCases, id: \.self) { unit in
                            Text(unit.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                    
                }
                /*
                if toggleDistance == true {
                    HStack(spacing: .zero) {
                        Picker("Magnitude", selection: $magnitude) {
                            ForEach(1..<101) { num in
                                Text(String(num))
                            }
                        }
                        .pickerStyle(.menu)
                        Picker("Unit", selection: $unit) {
                            ForEach(Units.allCases, id: \.self) { unit in
                                Text(unit.rawValue)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    
                }
                */
                Divider()
                    .padding(.vertical, 10)
                
                
                HStack {
                    Text("Effort")
                    Spacer()
                    // Picker (menu style) for effort type (Pace, None)
                    
                    
                    Button {
                        withAnimation {
                            toggle.toggle()
                        }
                        
                    } label: {
                        Text("5:15 /km")
                    }
                }
                
                
                if toggle == true {
                    HStack(spacing: .zero) {
                        Picker("", selection: $minutePace) {
                            ForEach(2..<11) { num in
                                Text("\(num) m")
                            }
                        }
                        .pickerStyle(.wheel)
                        //.frame(width: 80)
                        Text(":")
                        Picker("", selection: $secondPace) {
                            ForEach(0..<12) {   // add double zero (00)
                                Text("\($0*5) s")
                            }
                        }
                        .pickerStyle(.wheel)
                        //.frame(width: 80)
                        
                    }
                    .clipShape(Rectangle())
                }
            }
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
        
            
    }
}

struct EditStepView_Previews: PreviewProvider {
    static var previews: some View {
        EditStepView()
    }
}
