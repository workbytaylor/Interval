//
//  EditView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-12-28.
//

import SwiftUI

struct EditView: View {
    
    //@ObservedObject var workout: Workout
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var title: String = "Title"    // temp to use preview
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: .zero) {
                List {
                    Section {
                        TextField("Title", text: $title)
                            .multilineTextAlignment(.center)
                            .font(.system(.title2, design: .default, weight: .semibold))
                            .autocorrectionDisabled(false)
                            .autocapitalization(.sentences)
                        .overlay(alignment: .trailing) {
                            if title != "" {
                                Button {
                                    title = ""
                                } label: { Image(systemName: "xmark.circle.fill") }
                                .foregroundStyle(.secondary)
                            }
                        }
                    }
                    
                    Section(header: Text("Steps")) {
                        //ForEach()
                        Text("Step 1")
                    }
                }
                
                HStack {
                    Button {
                        //vm.addTimeStep()
                    } label: {
                        HStack { Label("Time", systemImage: "stopwatch"); Spacer(); Image(systemName: "plus") }
                    }
                    Button {
                        //vm.addDistanceStep()
                    } label: {
                        HStack { Label("Distance", systemImage: "lines.measurement.horizontal"); Spacer(); Image(systemName: "plus") }
                    }
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
                .padding()
                // TODO: Delete workout button (needs to dismiss to ContentView)
            }
            .background(Color(red: 242/255, green: 241/255, blue: 247/255))
            .navigationTitle("Edit workout")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                //title = workout.wrappedTitle
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
                    if title == ""/* || workout.stepsArray.count == 0 */{
                        Text("Save")
                            .foregroundStyle(.secondary)
                    } else {
                        Button {
                            saveChanges()
                            dismiss()
                        } label: {
                            Text("Save")
                                .bold()
                        }
                    }
                }
            }
        }
    }
    
    private func saveChanges() {
        // TODO: Overwrite existing workout
    }
    
    
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EditView()
        }
    }
}
