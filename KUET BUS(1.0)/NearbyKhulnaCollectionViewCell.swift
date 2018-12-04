//
//  NearbyKhulnaCollectionViewCell.swift
//  KUET BUS(1.0)
//
//  Created by Rifat on 12/3/18.
//  Copyright © 2018 Rifat. All rights reserved.
//

import UIKit
import UserNotifications


class NearbyKhulnaCollectionViewCell: UICollectionViewCell,UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound,.badge])
    }
    @IBOutlet weak var destination2: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var timeleft: UILabel!
    @IBOutlet weak var destination: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var remark: UILabel!
    
    var index: IndexPath?
    @IBAction func setAlarmKhulna(_ sender: UIButton) {
        
        createnotification()
    }
    
    
    
    func TimeInterval(time:String)->Double{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd h:mm a"
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "YYYY-MM-dd"
        
        var dateString = formatter.string(from: now)
        dateString += " " + time
        
        let date = dateFormatter.date(from: dateString)
        let interval = date?.timeIntervalSinceNow
        let t = Double(interval!)
        
        return t
    }
    
    
    func createnotification() {
        let content = UNMutableNotificationContent()
        content.title = NearByKhulna[(index?.row)!].title
        content.subtitle = NearByKhulna[(index?.row)!].remark
        content.body = "Your bus is about to leave.Hurry up!!!"
        content.sound = UNNotificationSound.default()
        let timeint = TimeInterval(time: NearByKhulna[(index?.row)!].time)
        
        let triger = UNTimeIntervalNotificationTrigger(timeInterval: timeint-600.00, repeats: false)
        
        
        let request = UNNotificationRequest(identifier: "Identifier", content: content, trigger: triger)
        
        UNUserNotificationCenter.current().add(request){ (error) in
            print(error as Any)
        }
    }
    
}
