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
                    Section {
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
                        Text("Steps...")
                    }
                }
                
                Divider()
                
                List {
                    Section(header: Text("Suggested steps")) {
                        
                    }
                }
                .frame(maxHeight: 250)
                
                //grid of buttons
                // similar to notion?
            }
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
            //.sheet()
            
        }
        
    }
}

struct NewView_Previews: PreviewProvider {
    static var previews: some View {
        NewView()
    }
}
