//
//  TodoItemModel.swift
//  TodoItemModel
//
//  Created by Кира on 14.06.2023.
//

import Foundation

struct TodoItem {
    var id: String
    let text: String
    let deadline: Date?
    let doneFlag: Bool
    let creationDate: Date
    let modifiedDate: Date?
    let importance: String

    init(
        id: String? = UUID().uuidString,
        text: String,
        deadline: Date? = nil,
        doneFlag: Bool = false,
        creationDate: Date = Date(),
        modifiedDate: Date? = nil,
        importance: Importance = .normal
    ) {
        self.id = id ?? UUID().uuidString
        self.text = text
        self.deadline = deadline
        self.doneFlag = doneFlag
        self.creationDate = creationDate
        self.modifiedDate = modifiedDate
        self.importance = importance.rawValue
    }
}

enum Importance: String {
    case unimportant = "unimportant"
    case normal = "normal"
    case important = "important"
}

extension TodoItem {
    var json: Any {
        var dict: [String: Any] = [
            "id": id,
            "text": text,
            "doneFlag": doneFlag,
            "creationDate": creationDate.timeIntervalSince1970
        ]
        if importance != "normal" {
            dict["importance"] = importance
        }
        
        if let deadline = deadline {
            dict["deadline"] = deadline.timeIntervalSince1970
        }
        if let modifiedDate = modifiedDate {
            dict["modifiedDate"] = modifiedDate.timeIntervalSince1970
        }
        
        return dict
    }
    
    static func parse(json: Any) -> TodoItem? {
        var todoItem: TodoItem? = nil
        var dict = (json as! [String: Any])
        var deadline: Date?
        var modifiedDate: Date?
        
        do {
            guard let id = dict["id"] as? String,
                  let text = dict["text"] as? String,
                  let doneFlag = dict["doneFlag"] as? Bool,
                  let importance = dict["importance"] as? Importance.RawValue,
                  let creationDateInterval = dict["creationDate"] as? TimeInterval
            else {
                return nil
            }
        
            if dict.index(forKey: "deadline") != nil {
                deadline =  Date(timeIntervalSince1970: dict["deadline"] as! TimeInterval)
            } 
            if dict.index(forKey: "modifiedDate") != nil {
                modifiedDate = Date(timeIntervalSince1970: dict["modifiedDate"] as! TimeInterval)
            }
            let creationDate = Date(timeIntervalSince1970: creationDateInterval)
            todoItem = TodoItem(id: id,
                                    text: text,
                                    deadline: deadline,
                                    doneFlag: doneFlag,
                                    creationDate: creationDate,
                                    modifiedDate: modifiedDate,
                                    importance: Importance(rawValue: importance) ?? .normal)

        } catch {
            print("Failed to parse json")
        }
        return todoItem
    }
}

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
        if importance != "normal" {
            string += importance + ";"
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
            deadline = Date(timeIntervalSince1970: Double(values[2]) as! TimeInterval)
        }
        if !values[3].isEmpty {
            if values[3] == "true" {
                doneFlag = true
            } else {
                doneFlag = false
            }
        }
        if !values[4].isEmpty {
            creationDate = Date(timeIntervalSince1970: Double(values[4]) as! TimeInterval)
        }
        if !values[5].isEmpty {
            modifiedDate = Date(timeIntervalSince1970: Double(values[5]) as! TimeInterval)
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
