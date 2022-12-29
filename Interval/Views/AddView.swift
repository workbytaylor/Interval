//
//  AddView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-23.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = ViewModel()
    
    @State private var showStepEditor: Bool = true
    
    @State private var pace: String = ""
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
            VStack(spacing: .zero) {
                List {
                    Section(/*footer: Text("Please choose a different title.")*/) {
                        TextField("Title", text: $vm.newTitle)
                            //.multilineTextAlignment(.center)
                            .font(.system(.title2, design: .default, weight: .semibold))
                            .autocorrectionDisabled(false)
                            .autocapitalization(.sentences)
                        // TODO: check for other titles that match current input
                        .overlay(alignment: .trailing) {
                            if vm.newTitle != "" {
                                Button {
                                    vm.newTitle = ""
                                } label: { Image(systemName: "xmark.circle.fill") }
                                .foregroundStyle(.secondary)
                            }
                        }
                    }
                    
                    Section(header: Text("Steps")) {
                        ForEach($vm.newSteps, id: \.id, editActions: .all) { $step in
                            HStack {
                                // change to switch statement when more step types are added
                                Image(systemName: step.type == "distance" ? "lines.measurement.horizontal" : "stopwatch")
                                    .frame(width: 40)
                                VStack(alignment: .leading) {
                                    Text("\(step.magnitude) \(step.unit)")
                                    Text(step.pace)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                                Button {
                                    // edit selected step
                                    showStepEditor.toggle()
                                } label: {
                                    Image(systemName: "ellipsis")
                                        .foregroundColor(.primary)
                                }
                            }
                            .deleteDisabled(vm.newSteps.count < 2)
                        }
                    }
                }
                
                ZStack(alignment: .bottom) {
                    HStack {
                        Button {
                            vm.addTimeStep()
                        } label: {
                            HStack { Label("Time", systemImage: "stopwatch"); Spacer(); Image(systemName: "plus") }
                        }
                        Button {
                            vm.addDistanceStep()
                        } label: {
                            HStack { Label("Distance", systemImage: "lines.measurement.horizontal"); Spacer(); Image(systemName: "plus") }
                        }
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                    .padding()
                    
                    
                    if showStepEditor == true {
                        
                        VStack(alignment: .leading, spacing: .zero) {
                            HStack {
                                Text("Edit Step")
                                    .font(.system(.headline))
                                Spacer()
                                Button {
                                    showStepEditor.toggle()
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            // TODO: Check uber bottom sheet
                            // TODO: FIx width of textfields
                            // TODO: Study pickers with apple human interaction guidelines
                            // TODO: Focus state for bottom sheet? Tapping title should dismiss it
                            // TODO: Dynamically change textfield prompt based on unit selection (ie. "distance", "time")
                            
                            HStack {
                                Text("Distance")
                                Spacer()
                                TextField("0", text: $magnitude)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 50)
                                    .padding(.horizontal).padding(.vertical, 4) // TODO: Fix this syntax
                                    .background(Color(red: 244/255, green: 244/255, blue: 245/255))
                                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                    .padding(.vertical)
                            }
                            Divider()
                            HStack {
                                Text("Unit")
                                Spacer()
                                Picker("Unit", selection: $unit) {
                                    ForEach(Units.allCases, id: \.self) { unit in
                                        Text(unit.rawValue)
                                    }
                                }
                                .pickerStyle(.menu)
                                .padding(.vertical)
                            }
                            Divider()
                            
                            HStack {
                                Text("Pace")
                                Spacer()
                                TextField("Pace", text: $pace)
                                    .frame(width: 40)
                                Text("/ km")
                            }
                            .padding(.vertical)
                        }
                        .padding()
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .padding()
                    }
                }
            }
            .background(Color(red: 242/255, green: 241/255, blue: 247/255))
            .navigationTitle("Add a workout")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear { vm.addDistanceStep() }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(role: .cancel) {
                        dismiss()
                    } label: {
                        Text("Cancel").tint(.red)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if vm.newTitle == "" || vm.newSteps.count == 0 {
                        Text("Save")
                            .foregroundStyle(.secondary)
                    } else {
                        Button {
                            createWorkout()
                        } label: {
                            Text("Save")
                                .bold()
                        }
                    }
                }
            }
        }
    }
    
    
    
    
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
