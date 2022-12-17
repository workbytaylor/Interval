//
//  AddView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-23.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm = ViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: .zero) {
                List {
                    Section(header: Text("Title"), footer: Text("Error message here")) {
                        TextField("Workout title", text: $vm.newTitle)
                            .autocorrectionDisabled(false)
                            .autocapitalization(.sentences)
                        // TODO: check for other titles that match current input
                        .overlay(alignment: .trailing) {
                            if vm.newTitle != "" {
                                Button {
                                    vm.newTitle = ""
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                }
                                .foregroundStyle(.secondary)
                            }
                        }
                    }
                    
                    Section(header: Text("Steps")) {
                        if vm.newSteps.count != 0 {
                            //TODO: How is index managed with this? Try id by index.
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
                                }
                                .deleteDisabled(vm.newSteps.count < 2)
                            }
                            .onMove { indices, newOffset in
                                vm.newSteps.move(fromOffsets: indices, toOffset: newOffset)
                                
                            }
                        } else {
                            HStack {
                                Spacer()
                                Text("Tap")
                                Image(systemName: "plus")
                                Text("to add a step")
                                Spacer()
                            }
                            .listRowBackground(Color.clear)
                            .foregroundStyle(.secondary)
                        }
                    }
                }
                
                HStack {
                    Button {
                        vm.addTimeStep()
                    } label: {
                        HStack {
                            Label("", systemImage: "stopwatch")
                            Spacer()
                            Image(systemName: "plus")
                        }
                    }
                    Button {
                        vm.addDistanceStep()
                    } label: {
                        HStack {
                            Label("", systemImage: "lines.measurement.horizontal")
                            Spacer()
                            Image(systemName: "plus")
                        }
                    }
                    
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
                .padding()
                .background(Color(red: 242/255, green: 241/255, blue: 247/255))
                
            }
            .navigationTitle("Add a workout")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(role: .cancel) {
                        dismiss()
                    } label: {
                        Text("Cancel").tint(.red)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if vm.newTitle == ""/* || newSteps.count == 0*/ {
                        Text("Save")
                            .foregroundStyle(.secondary)
                            .bold()
                    } else {
                        Button {
                            // save new workout
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
    
    private func createWorkout() {
        let newWorkout = Workout(context: moc)
        newWorkout.id = UUID()
        newWorkout.title = vm.newTitle
        //TODO: Continue saving new steps
        if moc.hasChanges {
            try? moc.save()
        }
        dismiss()
    }
    
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
