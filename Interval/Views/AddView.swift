//
//  AddView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-15.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = AddView_ViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: .zero) {
                List {
                    Section(header: Text("Title")) {
                        TextField("Workout title", text: $viewModel.newTitle)
                        .overlay(alignment: .trailing) {
                            if viewModel.newTitle != "" {
                                Button {
                                    viewModel.newTitle = ""
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                }
                                .foregroundStyle(.secondary)
                            }
                        }
                    }
                    Section(header: Text("Steps")) {
                        if viewModel.newSteps != [] {
                            ForEach(viewModel.newSteps, id: \.index) { step in
                                HStack {
                                    Text(String(step.index))    // for debugging only
                                    Text(String(step.target.magnitude))
                                    Text(step.target.unit)
                                }
                            }
                            .onDelete(perform: viewModel.deleteNewStep)
                        } else {
                            HStack {
                                Spacer()
                                Image(systemName: "plus")
                                Text("Add a step")
                                Spacer()
                            }
                            .foregroundStyle(.secondary)
                            .listRowBackground(Color.clear)
                        }
                    }
                }
                
                List {
                    Section(header: Text("Step Suggestions"), footer: Text("Tap to add a step")) {
                        Button {
                            viewModel.addDistanceStep()
                        } label: {
                            HStack {
                                Label("Distance", systemImage: "lines.measurement.horizontal")
                                Spacer()
                                Image(systemName: "plus")
                            }
                        }
                        Button {
                            viewModel.addTimeStep()
                        } label: {
                            HStack {
                                Label("Time", systemImage: "stopwatch")
                                Spacer()
                                Image(systemName: "plus")
                            }
                        }
                    }
                }.frame(height: 150)
                
                
            }
            .navigationTitle("Add a workout")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(role: .cancel) { dismiss() } label: { Text("Cancel").tint(.red) }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button() {
                        
                        dismiss()
                    } label: { Text("Save") }
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
