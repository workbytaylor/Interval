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
    
    @State private var showStepEditor: Bool = false
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: .zero) {
                List {
                    Section(/*footer: Text("Please choose a different title.")*/) {
                        TextField("Title", text: $vm.newTitle)
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
                                VStack(alignment: .leading) {
                                    Text("\(step.magnitude) \(step.unit)")
                                        .font(.headline)
                                    Text(step.pace)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                                .padding(.leading)
                                Spacer()
                                Button {
                                    withAnimation {
                                        showStepEditor.toggle()
                                    }
                                    
                                } label: {
                                    Image(systemName: "ellipsis")
                                        .foregroundColor(.primary)
                                }
                            }
                            .deleteDisabled(vm.newSteps.count < 2)
                        }
                        
                            HStack {
                                Image(systemName: "repeat")
                                VStack(alignment: .leading) {
                                    Text("5 km")
                                        .font(.headline)
                                    Text("distancePace")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                        .padding(.bottom)
                                    
                                    Text("5 km")
                                        .font(.headline)
                                    Text("distancePace")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                                .padding(.leading)
                            }
                            
                        
                        
                        
                        
                    }
                }
                
                ZStack(alignment: .bottom) {
                    if showStepEditor == true {
                        //EditStepView()
                    } else {
                        Menu {
                            Button {
                                vm.addTimeStep()
                            } label: {
                                Label("Time", systemImage: "stopwatch")
                            }
                            Button {
                                vm.addDistanceStep()
                            } label: {
                                Label("Distance", systemImage: "lines.measurement.horizontal")
                            }
                        } label: {
                            Label("Add step", systemImage: "plus")
                        }
                    }
                }
                .padding()
            }
            .background(Color(red: 242/255, green: 241/255, blue: 247/255))
            .navigationTitle("New Workout")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear { vm.addDistanceStep() }
            
            .sheet(isPresented: $showStepEditor) {
                EditStepView()
                    .presentationDetents([.medium])
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(role: .cancel) {
                        dismiss()
                    } label: {
                        Text("Cancel").tint(.red)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        createWorkout()
                    } label: {
                        Text("Save")
                            .bold()
                    }
                    .disabled(vm.newTitle == "" || vm.newSteps.count == 0)
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
