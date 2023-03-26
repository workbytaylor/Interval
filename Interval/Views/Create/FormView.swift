//
//  FormView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-03-20.
//

import SwiftUI

struct FormView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @Binding var step: CreateViewStep
    
    //@State var type: String
    var types: [String] = ["distance", "time"]
    
    
    /*init(step: CreateViewStep) {
        self.step = step
        _type = State(initialValue: step.type)
    }*/
    
    var body: some View {
        List {
            Section {
                // select step type
                Picker("Type", selection: $step.type) {
                    ForEach(types, id: \.self) {
                        Text($0.capitalized)
                    }
                }
                
                // length picker
                // repeat button
                //
                
                
                
            }
        }
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView(step: .constant(CreateViewStep()))
    }
}
