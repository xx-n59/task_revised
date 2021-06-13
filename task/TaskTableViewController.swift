//
//  TaskTableViewController.swift
//  task
//
//  Created by 布川のぞみ on 2021/02/07.
//

import UIKit
import RealmSwift
class TaskTableViewController: UITableViewController, UNUserNotificationCenterDelegate {
    //realmを読み込む
    let realm = try! Realm()
    //textFieldのテキスト
    var content = UITextField()
    var checkcell = UITableViewCell()
    //realmから受け取ったデータを入れる変数
    var todoArray: Results<Task>!
    //checkがあるかどうか
    var done: Bool = false
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //realm内の情報を初期化
        let task: Task? = read()
        //NavigationViewの背景色
        self.navigationController?.navigationBar.barTintColor = UIColor (red: 188/255, green: 226/255, blue: 232/255, alpha: 1.0)
     //todoArrayを取得
        self.todoArray = realm.objects(Task.self)
        print(self.todoArray)
    }
    //read内のメソッド
    func read() -> Task? {
        return realm.objects(Task.self).first
    }
    //+ボタン
    @IBAction func addBtn() {
        //アラートを表示
        let alert = UIAlertController(title: "追加", message: "タスクを追加する", preferredStyle: .alert)
        //アラートのキャンセルボタン
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: {(action: UIAlertAction!) -> Void in})
        alert.addAction(cancelAction)
        //テキストフィールドを追加
        alert.addTextField(configurationHandler: { [self](textField: UITextField) -> Void in
            //textFieldの設定
            textField.placeholder = ""
            textField.keyboardType = .default
            content = textField
        } )
        //アラートの保存ボタン
        let okAction = UIAlertAction(title: "保存", style: .default, handler: { action in
            //ボタンが押された時
            let title: String = self.content.text!
            //読み込む
            let task = Task()
            task.title = self.content.text!
            //realmにtextFieldの情報を加える
            try! self.realm.write {
                self.realm.add(task)
                self.tableView.reloadData()
            }
//tableViewを更新
        })
        alert.addAction(okAction)
        //アラートを表示
        self.present(alert, animated: true, completion: nil)
    }
        // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rowsret
        return todoArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //ID付きのcellを取得
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let TodoArray: Task = self.todoArray[indexPath.row]
        print(TodoArray)
        //取得した情報をCellに反映
        cell?.textLabel?.text = TodoArray.title
        return cell!
    }
    //cellがタップされた時の処理
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        //チェックマークを入れる
        cell?.accessoryType = .checkmark
        done = true
        //読み込む
        let isdone = Task()
        isdone.isDone = self.done
        try! self.realm.write {
            self.realm.add(isdone)
            self.tableView.reloadData()
        }
    }
}
