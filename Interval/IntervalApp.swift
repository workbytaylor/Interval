//
//  IntervalApp.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-13.
//

import SwiftUI

@main
struct IntervalApp: App {
    
    //@StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
            .environment(\.managedObjectContext, WorkoutsProvider.shared.viewContext)
        }
    }
}
