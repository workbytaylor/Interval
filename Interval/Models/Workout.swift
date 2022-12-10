//
//  Workout.swift
//  Interval
//
//  Created by Nilakshi Roy on 2022-11-14.
//

import Foundation

class Workout: Identifiable, ObservableObject, Codable {
    var id: UUID = UUID()
    @Published var title: String = "Placeholder title"
    @Published var steps: [Step] = []
    
    private enum CodingKeys: CodingKey {
        case title
        case steps
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        steps = try container.decode([Step].self, forKey: .steps)
    }
    
    init() { }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(steps, forKey: .steps)
    }
}

class Step: Identifiable, Equatable, ObservableObject, Codable {
    var id: UUID = UUID()
    @Published var index: Int = 1
    @Published var type: String = "distance"
    @Published var target: Target = Target()    //TODO: Suspect that these intial values need to be loaded from files somehow before they can be used
    @Published var pace: String = "5.15 /km"
    
      // unsure if this is necessary now that it is a class
    static func ==(lhs: Step, rhs: Step) -> Bool {
        return lhs.index == rhs.index
    }
    
    private enum CodingKeys: CodingKey {
        case index
        case type
        case target
        case pace
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        index = try container.decode(Int.self, forKey: .index)
        type = try container.decode(String.self, forKey: .type)
        target = try container.decode(Target.self, forKey: .target)
        pace = try container.decode(String.self, forKey: .pace)
    }
    
    init() { }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(index, forKey: .index)
        try container.encode(type, forKey: .type)
        try container.encode(target, forKey: .target)
        try container.encode(pace, forKey: .pace)
    }
}

class Target: ObservableObject, Codable {
    @Published var magnitude: Int = 1
    @Published var unit: String = "km"
    
    private enum CodingKeys: CodingKey {
        case magnitude
        case unit
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        magnitude = try container.decode(Int.self, forKey: .magnitude)
        unit = try container.decode(String.self, forKey: .unit)
    }
    
    init() { }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(magnitude, forKey: .magnitude)
        try container.encode(unit, forKey: .unit)
    }
}

@MainActor class Workouts: ObservableObject {
    @Published var allworkouts: [Workout]
    
    init() {
        self.allworkouts = []
    }
    
    func deleteWorkout(at offsets: IndexSet) {
        allworkouts.remove(atOffsets: offsets)
    }
    
    // saves changes to workouts
    func save(_ workouts: [Workout]) {  //TODO: delete underscore?
        // Encode the array as a Data object
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(workouts)

            // Save the data to the documents directory
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsDirectory.appendingPathComponent("saved_workouts.json")
            do {
                try data.write(to: fileURL)
            } catch {
                // Handle error
            }
            
        } catch {
            // Handle error
        }
        
        
    }
    
    /*
    func addWorkout(new: Workout) {
        allworkouts.append(new)
    }
    */
    
}


