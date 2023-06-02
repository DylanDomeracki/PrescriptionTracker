import SwiftUI
import Foundation

struct TimerView: View {
    @State var nextDose: Date
    @State var timeUntilNextDose: String = ""
    
    var body: some View {
        Text(timeUntilNextDose + " until next dose")
            .font(
                .body
                .weight(.bold)
            )
            .onAppear(){
                timeUntilNextDose = TimeUntil(until: nextDose)
            }
    }
    
    func TimeUntil(until referenceDate: Date) -> String {
        let timeInterval = Calendar.current.dateComponents([.hour, .minute], from: Date.now, to: referenceDate)
        
        var timeString = "\(String(format: "%02d", timeInterval.hour ?? 0)):\(String(format: "%02d", timeInterval.minute ?? 0))"
        if(timeInterval.hour ?? 0 <= 0 && timeInterval.minute ?? 0 <= 0) {
            timeString = "00:00"
        }
        return timeString
    }
}
        
