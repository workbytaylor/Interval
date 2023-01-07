//
//  EditView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-23.
//

import SwiftUI

struct EditView: View {
    
    // CoreData is get only, so need to accept a universal step and workout with this view
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = ViewModel()
    
    @State var title: String = "Title"
    @State private var showStepEditor: Bool = false
    
    var body: some View {
        NavigationStack {
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
                        //moc.rollback()
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
                ToolbarItem(placement: .bottomBar) {
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
                        HStack {
                            Image(systemName: "plus")
                            Text("Add Step")
                        }
                        //Label("Add step", systemImage: "plus")
                    }
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
