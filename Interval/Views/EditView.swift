//
//  EditView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-23.
//

import SwiftUI

struct EditView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = ViewModel()
    
    @State var title: String = "Unknown"
    @State private var showStepEditor: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: .zero) {
                List {
                    Section(/*footer: Text("Please choose a different title.")*/) {
                        TextField("Add Title", text: $vm.newTitle)
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
                            NavigationLink {
                                EditStepView()
                            } label: {
                                HStack {
                                    // change to switch statement when more step types are added
                                    Image(systemName: step.type == "distance" ? "lines.measurement.horizontal" : "stopwatch")
                                    VStack(alignment: .leading) {
                                        Text("\(step.magnitude) \(step.unit)")
                                            //.font(.headline)
                                        Text(step.pace)
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                    }
                                    .padding(.leading)
                                }
                            }
                            .deleteDisabled(vm.newSteps.count < 2)
                        }
                    }
                }
                
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
                .padding()
            }
            .background(Color(red: 242/255, green: 241/255, blue: 247/255))
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear { vm.addFirstStep() }
            .sheet(isPresented: $showStepEditor) {
                EditStepView()
                    .presentationDetents([.large])
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
        EditView()
    }
}
