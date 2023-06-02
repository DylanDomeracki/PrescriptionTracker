import Foundation
struct Prescription: Identifiable, Codable, Equatable {
    var id: Int
    var medName: String //Escitalopram
    var brandName: String //Lexapro
    var doseAmount: Int //mg
    var doseFrequency: Int //hours between each dose
    var lastDose: Date //last time dose was taken
}
