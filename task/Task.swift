//
//  Task.swift
//  task
//
//  Created by 布川のぞみ on 2021/05/16.
//

import Foundation
import RealmSwift

class Task: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var isDone = false
}
