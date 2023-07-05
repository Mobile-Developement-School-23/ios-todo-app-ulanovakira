//
//  TodoItemModel+CSV.swift
//  TodoItem
//
//  Created by Кира on 29.06.2023.
//

import Foundation

extension TodoItem {
    var csv: String {
        var string = id + ";" + text + ";"
        
        if let deadline = deadline {
            string += String(deadline.timeIntervalSince1970) + ";"
        } else {
            string += ";"
        }
        string += String(doneFlag) + ";" + String(creationDate.timeIntervalSince1970) + ";"
        if let modifiedDate = modifiedDate {
            string += String(modifiedDate.timeIntervalSince1970) + ";"
        } else {
            string += ";"
        }
        if importance != .normal {
            string += importance.rawValue + ";"
        } else {
            string += ";"
        }
        return string
    }
    
    static func parse(csv: String) -> TodoItem? {
        var todoItem: TodoItem? = nil
        var deadline: Date?
        var modifiedDate: Date?
        let values = csv.components(separatedBy: ";")
        var id: String?
        var text: String = ""
        var doneFlag: Bool = false
        var creationDate: Date = Date()
        var importance: String = "normal"
        if !values[0].isEmpty {
            id = values[0]
        }
        if !values[1].isEmpty {
            text = values[1]
        }
        if !values[2].isEmpty {
            deadline = Date(timeIntervalSince1970: Double(values[2])!)
        }
        if !values[3].isEmpty {
            if values[3] == "true" {
                doneFlag = true
            } else {
                doneFlag = false
            }
        }
        if !values[4].isEmpty {
            creationDate = Date(timeIntervalSince1970: Double(values[4])!)
        }
        if !values[5].isEmpty {
            modifiedDate = Date(timeIntervalSince1970: Double(values[5])!)
        }
        if !values[6].isEmpty {
            importance = values[6]
        }
        
        todoItem = TodoItem(
            id: id,
            text: text,
            deadline: deadline,
            doneFlag: doneFlag,
            creationDate: creationDate,
            modifiedDate: modifiedDate,
            importance: Importance(rawValue: importance) ?? .normal
        )
            return todoItem
    }
}
