//
//  DatePickerViewController.swift
//  task
//
//  Created by 布川のぞみ on 2021/06/09.
//

import Foundation
import UIKit
import RealmSwift

class DatePickerViewController: UIViewController {
    //realmを読み込む
    let realm = try! Realm()
//realmから受け取ったデータを入れる変数
    var Todo: Results<Task>!
    var saveData: UserDefaults = UserDefaults.standard
    override func viewDidLoad() {
        //realm内の情報を初期化
        let task: Task? = read()
    }
    //read内のメソッド
    func read() -> Task? {
        return realm.objects(Task.self).first
    }
    //datePickerを宣言
    @IBOutlet var datePicker: UIDatePicker!
    //saveBtnの宣言
    @IBAction func save() {
        var fomatter = DateFormatter()
        fomatter.dateFormat = "hh:mm"
        saveData.set(fomatter.string(from: Date()), forKey: "time")
        fomatter = saveData.object(forKey: "time") as! DateFormatter
        //通知の中身を設定
        let content = UNMutableNotificationContent()
        content.sound = UNNotificationSound.default
        content.title = ""
        content.subtitle = "未完了"
        content.body = "\(Todo.count)"
        
        //時間を設定
        let date = fomatter.date(from: "hh:mm")
        let trigger: UNCalendarNotificationTrigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents(in: TimeZone.current, from: date!), repeats: false )
        
        //リクエストを作成
     let request: UNNotificationRequest = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error: Error?) in
            // エラーが存在しているかを確認
            if error != nil {
                
            } else {

            }
        }
}

}
