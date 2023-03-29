//
//  Step.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-03-28.
//

import Foundation

public class Step: ObservableObject, Identifiable {
    public let id: UUID = UUID()
    @Published var type: String = "time"
    @Published var magnitude: Int16 = 5
    @Published var unit: String = "minutes"
    @Published var pace: Int16 = 330   // seconds per km
}
