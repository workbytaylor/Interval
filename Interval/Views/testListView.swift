//
//  testListView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-12-30.
//

import SwiftUI

struct testListView: View {
    
    @State private var showBottomSheet: Bool = false
    @State private var selection: Int?// = 0
    
    var body: some View {
        ScrollViewReader { proxy in
            VStack {
                Button("Toggle sheet off") {
                    showBottomSheet = false
                    selection = nil
                }
                
                List(0..<100, id: \.self) { i in
                    Button("Selection \(i)") {
                        selection = i
                        showBottomSheet = true
                        
                        
                        withAnimation {
                            proxy.scrollTo(selection, anchor: .top)
                        }
                        
                    }
                    .id(i)
                    .listRowBackground(selection == i ? Color.accentColor.opacity(0.1) : nil)
                }
                
                if showBottomSheet == true {
                    Color.red.frame(height: 200)
                }
            }
        }
    }
}

struct testListView_Previews: PreviewProvider {
    static var previews: some View {
        testListView()
    }
}
