import Foundation
import SwiftUI

struct AddPrescription: View {
    @State var brandName : String  = ""
    @State var medicineName : String  = ""
    @State var doseAmount : Int =  0
    @State var doseFrequency : Int  = 0
    @State var doseFrequency2 : Int = 0
    @Binding var otcMeds : [OTCMed]
    @Binding var prescriptions : [Prescription]
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            VStack {
                List {
                    DetailTextField(title: "Brand Name", prompt: "Brand Name", boundString: $brandName)
                        .disableAutocorrection(true)
                        .font(
                            .title
                                .weight(.semibold)
                            
                        )
                    DetailTextField(title: "Medicine Name", prompt: "Medicine Name", boundString: $medicineName)
                        .disableAutocorrection(true)
                        .font(
                            .title
                                .weight(.semibold)
                            
                        )
                    DetailIntField(title: "Dose Amount (mg)", prompt: "Dose Amount", boundVar: $doseAmount)
                        .disableAutocorrection(true)
                        .font(
                            .title
                                .weight(.semibold)
                            
                        )
                    DetailIntField(title: "Dose Frequency (Hours)", prompt: "Dose Frequency", boundVar: $doseFrequency)
                        .disableAutocorrection(true)
                        .font(
                            .title
                                .weight(.semibold)
                            
                        )
                    Button {
                        dismiss()
                        otcMeds.append(OTCMed(id: otcMeds.count, medName: medicineName, brandName: brandName, doseAmount: doseAmount, doseFrequency: doseFrequency, lastDose: Date.now))
                        SaveLoad().saveArrays(rx: prescriptions, otc: otcMeds)
                        
                        let content = UNMutableNotificationContent()
                        content.title = "Take Medicine"
                        content.subtitle = "Timer is up"
                        content.sound = UNNotificationSound.default
                        
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(doseFrequency *  3600), repeats: false)
                        
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                        
                        print("OTC Notification Sending")
                        UNUserNotificationCenter.current().add(request)
                    } label: {
                        Text("Schedule Timer")
                            .font(
                                .title
                                    .weight(.semibold)
                                
                            )
                    }
                }
            }
        }
    }
}
