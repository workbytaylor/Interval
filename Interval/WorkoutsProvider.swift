//
//  WorkoutsProvider.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-01-20.
//

import Foundation
import CoreData
import SwiftUI

final class WorkoutsProvider {
    
    static let shared = WorkoutsProvider()
    
    private let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    var newContext: NSManagedObjectContext {
        persistentContainer.newBackgroundContext()
    }
    
    
    private init() {
        
        persistentContainer = NSPersistentContainer(name: "Interval")
        if EnvironmentValues.isPreview {
            persistentContainer.persistentStoreDescriptions.first?.url = .init(URL(fileURLWithPath: "/dev/null"))
        }
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        persistentContainer.loadPersistentStores { _, error in
            if let error {
                fatalError("Unable to load store with error: \(error)")
            }
        }
    }
}

extension EnvironmentValues {
    static var isPreview: Bool {
        return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}
