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
    
    @State private var lengthToggle: Bool = false
    @State private var paceToggle: Bool = false
    
    @State private var minutePace: Int = 3
    @State private var secondPace: Int = 0
    
    @State private var type = Types.distance
    enum Types: String, CaseIterable {
        case distance = "Distance"
        case time = "Time"
    }
    
    enum paceTypes: String
    
    
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
                HStack {
                    //Text("Length")
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
                            ForEach(1..<101) { magnitude in
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

                
                HStack {
                    //Text("Effort")
                    Label("Effort", systemImage: "bolt.fill")
                    Spacer()
                    
                    Picker("Unit", selection: $unit) {
                        ForEach(Units.allCases, id: \.self) { unit in
                            Text(unit.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                    
                }
                if paceToggle == true { // if _ == pace, then show pace picker
                    HStack(spacing: .zero) {
                        Picker("", selection: $minutePace) {
                            ForEach(2..<11) { num in
                                Text("\(num) m")
                            }
                        }
                        .pickerStyle(.wheel)
                        Text(":")
                        Picker("", selection: $secondPace) {
                            ForEach(0..<12) {   // add double zero (00)
                                Text("\($0*5) s")
                            }
                        }
                        .pickerStyle(.wheel)
                        
                    }
                    .clipShape(Rectangle())
                }
                
            }
            .navigationTitle("Edit Step")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct EditStepView_Previews: PreviewProvider {
    static var previews: some View {
        EditStepView()
    }
}
