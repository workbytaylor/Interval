//
//  AddView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-23.
//

import SwiftUI

struct NewSteps: Identifiable {
    var id: UUID
    var index: Int16
    var magnitude: Int16
    var unit: String
    var type: String
    var pace: String
}

struct AddView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) private var dismiss
    
    @State private var newSteps: [NewSteps] = []
    @State private var newIndex: Int = 1
    @State private var newTitle: String = ""
    
    enum Types: CaseIterable {
        case distance
        case time
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: .zero) {
                List {
                    Section(header: Text("Title"), footer: Text("Error message here")) {
                        TextField("Workout title", text: $newTitle)
                            .autocorrectionDisabled(false)
                            .autocapitalization(.sentences)
                        // TODO: check for other titles that match current input
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
                        if newSteps.count != 0 {
                            ForEach(newSteps, id: \.id) { step in
                                HStack {
                                    Image(systemName: step.type == "distance" ? "lines.measurement.horizontal" : "stopwatch")
                                        .frame(width: 40)
                                    VStack(alignment: .leading) {
                                        Text("\(step.magnitude) \(step.unit)")
                                        Text(step.pace)
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                            }
                            //.onDelete(perform: /*delete step*/)
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
                    ForEach(Types.allCases, id: \.self) { type in
                        Button {
                            // add step of appropriate type
                        } label: {
                            HStack {
                                Label("", systemImage: type == .distance ? "lines.measurement.horizontal" : "stopwatch")
                                Spacer()
                                Image(systemName: "plus")
                            }
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
                    if newTitle == ""/* || newSteps.count == 0*/ {
                        Text("Save")
                            .foregroundStyle(.secondary)
                            .bold()
                    } else {
                        Button {
                            // save new workout
                        } label: {
                            Text("Save")
                                .bold()
                        }
                    }
                }
            }
        }
    }
    
    private func deleteStep(at offsets: IndexSet) {
        //newSteps.remove(atOffsets: offsets)
    }
    
    private func addTimeStep() {
    }
    
    private func addDistanceStep() {
    }
    
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
