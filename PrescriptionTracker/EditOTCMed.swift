import SwiftUI

struct EditOTCMed: View {
    @Binding var med: OTCMed
    @Binding var rxArray: [Prescription]
    @Binding var otcArray: [OTCMed]
    @Environment(\.dismiss) private var dismiss
    @State var brand: String = ""
    @State var name: String = ""
    @State var amount: Int = 0
    @State var frequency: Int = 0
    
    var body: some View {
        ZStack {
            VStack {
                List {
                    DetailTextField(title: "Brand Name", prompt: "Lexapro", boundString: $brand)
                        .disableAutocorrection(true)
                        .font(
                            .title
                            .weight(.semibold)

                        )
                    DetailTextField(title: "Medicine Name", prompt: "Escitalopram", boundString: $name)
                        .disableAutocorrection(true)
                        .font(
                            .title
                            .weight(.semibold)

                        )
                    DetailIntField(title: "Dose Amount (mg)", prompt: "7", boundVar: $amount)
                        .disableAutocorrection(true)
                        .font(
                            .title
                            .weight(.semibold)

                        )
                    DetailIntField(title: "Dose Frequency (Hours)", prompt: "24", boundVar: $frequency)
                        .disableAutocorrection(true)
                        .font(
                            .title
                            .weight(.semibold)

                        )
                    Section {
                        Button {
                            med.brandName = brand
                            med.medName = name
                            med.doseAmount = amount
                            med.doseFrequency = frequency
                            SaveLoad().saveArrays(rx: rxArray, otc: otcArray)
                            dismiss()
                        } label: {
                            Text("Save")
                                .font(
                                    .title
                                    .weight(.semibold)

                                )
                        }
                        
                        Button {
                            med.lastDose = Date.now
                            NotificationManager().scheduleNotification(title: "Medication Timer", subtitle: "Take a dose of \(brandName) (\(medicineName))", timeInterval: Double(med.doseFrequency * 3600))
                        } label: {
                            Text("Restart Timer")
                                .font(
                                    .title
                                    .weight(.semibold)

                                )
                        }
                        
                        Button {
                            if let index = otcArray.firstIndex(of: med){
                                otcArray.remove(at: index)
                            }
                            SaveLoad().saveArrays(rx: rxArray, otc: otcArray)
                            dismiss()
                        } label: {
                            Text("Delete")
                                .font(
                                    .title
                                    .weight(.semibold)

                                )
                        }
                    }

                }
            }
        }
        .onAppear() {
            brand = med.brandName
            name = med.medName
            amount = med.doseAmount
            frequency = med.doseFrequency
        }
    }
}
