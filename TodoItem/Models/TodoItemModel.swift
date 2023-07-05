//
//  TodoItemModel.swift
//  TodoItemModel
//
//  Created by Кира on 14.06.2023.
//

import Foundation

struct TodoItem {
    let id: String
    let text: String
    let deadline: Date?
    let doneFlag: Bool
    let creationDate: Date
    let modifiedDate: Date?
    let importance: Importance

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
        self.importance = importance
    }
}

enum Importance: String {
    case unimportant = "unimportant"
    case normal = "normal"
    case important = "important"
}

