//
//  AddView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-23.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var newTitle: String = ""
    @State var newSteps: [Step] = []
    
    var body: some View {
        NavigationStack {
            VStack(spacing: .zero) {
                List {
                    Section(header: Text("Title")) {
                        TextField("Workout title", text: $newTitle)
                        .overlay(alignment: .trailing) {
                            if newTitle != "" {
                                Button {
                                    newTitle = ""
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                }
                                .foregroundStyle(.secondary)
                            }
                        }
                    }
                    
                    Section(header: Text("Steps")) {
                        if newSteps != [] {
                            ForEach(newSteps, id: \.index) { step in
                                HStack {
                                    Text(String(step.index))    // for debugging only
                                    Text(String(step.target.magnitude))
                                    Text(step.target.unit)
                                }
                            }
                        } else {
                            HStack {
                                Spacer()
                                Text("Tap")
                                Image(systemName: "plus")
                                Text("to add a step.")
                                Spacer()
                            }
                            .foregroundStyle(.secondary)
                            .listRowBackground(Color.clear)
                        }
                    }
                }
                List {
                    Section(header: Text("Step Suggestions")/*, footer: Text("Tap to add a step")*/) {
                        Button {
                            newSteps.append(Step())
                        } label: {
                            HStack {
                                Label("Distance", systemImage: "lines.measurement.horizontal")
                                Spacer()
                                Image(systemName: "plus")
                            }
                        }
                        Button {
                            newSteps.append(Step())
                        } label: {
                            HStack {
                                Label("Time", systemImage: "stopwatch")
                                Spacer()
                                Image(systemName: "plus")
                            }
                        }
                    }
                }.frame(height: 150)    // use geometryreader? to adjust based on dynamic text size
            }
            .navigationTitle("Add a workout")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(role: .cancel) { dismiss() } label: { Text("Cancel").tint(.red) }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { dismiss() } label: { Text("Save") }
                }
            }
            
        }
        
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(newTitle: "")
    }
}
