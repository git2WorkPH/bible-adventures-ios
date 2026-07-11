import Foundation

struct AnimalPair: Identifiable {

    let id: String
    let name: String
    let emoji: String
}

struct AnimalCard: Identifiable {

    let id = UUID()
    let animalID: String
    let name: String
    let emoji: String
}
