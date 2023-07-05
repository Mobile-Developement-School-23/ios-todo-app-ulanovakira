//
//  TodoItemModel+JSON.swift
//  TodoItem
//
//  Created by Кира on 29.06.2023.
//

import Foundation

extension TodoItem {
    var json: Any {
        var dict: [String: Any] = [
            "id": id,
            "text": text,
            "doneFlag": doneFlag,
            "creationDate": creationDate.timeIntervalSince1970
        ]
        if importance != .normal {
            dict["importance"] = importance.rawValue
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
        let dict = (json as! [String: Any])
        var deadline: Date?
        var modifiedDate: Date?

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


        return todoItem
    }
}
