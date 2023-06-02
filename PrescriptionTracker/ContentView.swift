import SwiftUI
import UserNotifications

struct ContentView: View {
    @State var prescriptions: [Prescription] = SaveLoad().loadArrays().0
    @State var otcMeds: [OTCMed] = SaveLoad().loadArrays().1
    
    var body: some View {
        VStack {
           
            Rectangle()
                .frame(width: .infinity, height: 60)
                .foregroundColor(.indigo)
            
            NavigationLink("Settings") {
                NotificationsView()
            }
            
            NavigationView {
                List {
                    Section("**Prescription**") {
                        ForEach($prescriptions) { item in
                            let name: String = item.medName.wrappedValue
                            let brand: String = item.brandName.wrappedValue
                            let amount: Int = item.doseAmount.wrappedValue
                            let frequency: Int = item.doseFrequency.wrappedValue
                            let lastDose: Date = item.lastDose.wrappedValue
                            NavigationLink {
                                EditPrescription(rx: item, rxArray: $prescriptions, otcArray: $otcMeds)
                            } label: {
                                RxListItem(name: name, brand: brand, amount: amount, frequency: frequency, lastDose: lastDose)
                            }
                        }
                        NavigationLink {
                            AddPrescription(otcMeds: $otcMeds, prescriptions: $prescriptions)
                        } label: {
                            Text("**Add New +**")
                                .font(
                                    .title
                                        .weight(.semibold)
                                )
                        }
                    }
                    .font(
                        .title
                            .weight(.semibold)
                        
                    )
                    Section("Over-the-Counter") {
                        ForEach($otcMeds) { item in
                            let name: String = item.medName.wrappedValue
                            let brand: String = item.brandName.wrappedValue
                            let amount: Int = item.doseAmount.wrappedValue
                            let frequency: Int = item.doseFrequency.wrappedValue
                            let lastDose: Date = item.lastDose.wrappedValue
                            NavigationLink {
                                EditOTCMed(med: item, rxArray: $prescriptions, otcArray: $otcMeds)
                            } label: {
                                OTCListItem(name: name, brand: brand, amount: amount, frequency: frequency, lastDose: lastDose)
                            }
                        }
                        NavigationLink {
                            AddOTCMed(otcMeds: $otcMeds, prescriptions: $prescriptions)
                        } label: {
                            Text("**Add New +**")
                                .font(
                                    .title
                                        .weight(.semibold)
                                    
                                )
                            
                        }
                    }
                    .font(
                        .title
                            .weight(.semibold)
                        
                    )
                    Button("Request Permission") {
                        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                            if success {
                                print("Request Accepted")
                            } else if let error = error {
                                print(error.localizedDescription)
                            }
                        }            }
                }
                .listStyle(.sidebar)
                
            }
            .navigationViewStyle(.stack)
            .navigationTitle("Active Medications")
            
            Rectangle()
                .frame(width: .infinity, height: 100)
                .foregroundColor(.indigo)
        }
        
        .ignoresSafeArea()
        
    }
}

struct OTCListItem: View {
    let name: String
    let brand: String
    let amount: Int
    let frequency: Int
    let lastDose: Date
    var body: some View {
        VStack(alignment: .leading) {
            Text("**\(brand) (\(name))**")
                .font(
                    .title
                        .weight(.semibold)
                    
                )
            Text(verbatim: "\(amount) mg Every \(frequency == 1 ? "Hour" : "\(frequency) Hours")")
                .font(
                    .body
                        .weight(.bold)
                )
            TimerView(nextDose: lastDose.addingTimeInterval(TimeInterval(frequency * 3600)))
        }
    }
}

struct RxListItem: View {
    let name: String
    let brand: String
    let amount: Int
    let frequency: Int
    let lastDose: Date
    var body: some View {
        VStack(alignment: .leading) {
            Text("**\(brand) (\(name))**")
                .font(
                    .title
                        .weight(.semibold)
                    
                )
            Text(verbatim: "\(amount) mg Every \(frequency == 1 ? "Hour" : "\(frequency) Hours")")
                .font(
                    .body
                        .weight(.bold)
                )
            TimerView(nextDose: lastDose.addingTimeInterval(TimeInterval(frequency * 3600)))
        }
    }
}
