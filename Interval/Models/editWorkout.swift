//
//  editWorkout.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-01-09.
//

import Foundation

struct EditWorkout: Identifiable {
    var id: UUID
    var title: String?  // not required to have a title
    var steps: [EditStep?]   // this workout may or may not have steps
}
