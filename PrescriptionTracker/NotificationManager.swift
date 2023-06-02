import SwiftUI
import UserNotifications

struct NotificationManager {
    func scheduleNotification(title: String, subtitle: String, timeInterval: Double) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Notifications Permissions Granted")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
