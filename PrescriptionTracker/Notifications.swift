import UserNotifications
import SwiftUI
func Notification() {
  UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {

              
            } else if let error = error {
               
            }
        }
        
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        let content = UNMutableNotificationContent()
        content.title = "Medicine"
        content.body = "Daily Notification is Ready"
        content.sound = UNNotificationSound.default

        var dateComponents = DateComponents()
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
}
