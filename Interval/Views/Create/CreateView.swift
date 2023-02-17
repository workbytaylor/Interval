//
//  CreateView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-02-16.
//

import SwiftUI

struct CreateView: View {
    @Environment(\.dismiss) var dismiss
    @State var newWorkout: Workout
    @State var steps: [Step]
    
    var body: some View {
        List {
            Section {
                // textfield
            } header: {
                Text("Title")
            }
            
            Section {
                // list steps
            } header: {
                Text("Steps")
            }
        }
        
        
        
        
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView(newWorkout: Workout(), steps: [])
    }
}
