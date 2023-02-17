//
//  WorkoutsProvider.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-01-20.
//

import Foundation
import CoreData
import SwiftUI

final class WorkoutsProvider: ObservableObject {
    let container = NSPersistentContainer(name: "Interval")
    
    init() {
        //container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Unable to load store with error: \(error.localizedDescription)")
            }
        }
    }
}
