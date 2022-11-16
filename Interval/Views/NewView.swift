//
//  NewView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-15.
//

import SwiftUI

struct NewView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var title: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: .zero) {
                List {
                    Section(header: Text("Title")) {
                        TextField("Workout title", text: $title)
                        .overlay(alignment: .trailing) {
                            if title != "" {
                                Button {
                                    title = ""
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                }
                                .foregroundStyle(.secondary)
                            }
                        }
                    }
                    
                    Section(header: Text("Steps")) {
                        Text("Step 1")
                        Text("Step 2")
                    }
                    
                    Section(header: Text("Suggestions")) {
                        Button(action: {}) {
                            HStack {
                                Label("Distance", systemImage: "lines.measurement.horizontal")
                                Spacer()
                                Image(systemName: "plus")
                            }
                        }
                        Button(action: {}) {
                            HStack {
                                Label("Time", systemImage: "stopwatch")
                                Spacer()
                                Image(systemName: "plus")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Add a workout")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(role: .cancel) {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .tint(.red)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button() {
                        // save new workout
                    }label: {
                        Text("Save")
                    }
                }
            }
            
        }
        
    }
}

struct NewView_Previews: PreviewProvider {
    static var previews: some View {
        NewView()
    }
}
