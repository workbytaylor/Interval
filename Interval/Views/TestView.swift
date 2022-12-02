//
//  TestView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-12-01.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        NavigationStack {
            List {
                HStack {
                    Image(systemName: "repeat")
                        .frame(width: 40)
                    
                    VStack {
                        Text("800")+Text("meters")
                        Text("5.15 /km")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                
                
                
                HStack(alignment: .firstTextBaseline) {
                    Image(systemName: "repeat")
                        .frame(width: 40)
                    
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            
                            Text("+/-")
                        }
                        
                        VStack(alignment: .leading) {
                            Text("800")+Text("meters")
                            Text("5.15 /km")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("800")+Text("meters")
                            Text("5.15 /km")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                }
            }
            .navigationTitle("Test View")
        }
        
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
