import Foundation
struct OTCMed: Identifiable, Codable, Equatable {
    var id: Int
    var medName: String //Ibuprofen
    var brandName: String //Advil
    var doseAmount: Int //mg
    var doseFrequency: Int //hours between each dose
    var lastDose: Date //last time medicine was taken
}
