//
//  FileCache.swift
//  TodoItem
//
//  Created by Кира on 15.06.2023.
//

import Foundation

class FileCache {
    private(set) var todoItems = [TodoItem]()
    
    func addItem(item: TodoItem) {
        if let id = todoItems.firstIndex(where: { $0.id == item.id }) {
            todoItems[id] = item
        } else {
            todoItems.append(item)
        }
    }
    
    func removeItem(with id: String) {
        if let id = todoItems.firstIndex(where: { $0.id == id }) {
            todoItems.remove(at: Int(id))
        }
    }
    
    func saveToJson(to filename: String) {
        var jsonTodoItems = [[:]]
        for item in todoItems {
            let jsonItem: [String: Any] = item.json as! [String : Any]
            jsonTodoItems.append(jsonItem)
        }
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentDirectoryUrl.appendingPathComponent(filename + ".json")
        print("file url is \(fileUrl)")

        do {
            let data = try JSONSerialization.data(withJSONObject: jsonTodoItems, options: [])
            try data.write(to: fileUrl)
        } catch {
            print("Failed to save to \(filename) \(error.localizedDescription)")
        }
    }
    
    func loadFromJson(from file: URL) {
        if FileManager.default.fileExists(atPath: file.absoluteString) {
            do {
                let jsonData = try Data(contentsOf: URL(string: "file://\(file.absoluteURL)")!)
                let decoded = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! [[String: Any]]
                print("decoded \(decoded)")
                for item in decoded {
                    print("item \(item)")
                    let it = TodoItem.parse(json: item)
                    if it != nil {
                        addItem(item: it!)
                    }
                }
            } catch {
                print("Can't load \(file) \(error.localizedDescription)")
            }
        } else {
            print("File \(file) doesn't exists")
        }
    }
    
    func saveToCSV(to filename: String) {
        var csvTodoItems: String = ""
        for item in todoItems {
            let csvItem: String = item.csv 
            csvTodoItems += csvItem + "\n"
        }
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentDirectoryUrl.appendingPathComponent(filename + ".csv")
        print("file url is \(fileUrl)")

        do {
            try csvTodoItems.write(to: fileUrl, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("Failed to save to \(filename) \(error.localizedDescription)")
        }
    }

    func loadFromCSV(from file: URL) {
        if FileManager.default.fileExists(atPath: file.absoluteString) {
            do {
                let csvData = try String(contentsOf: URL(string: "file://\(file.absoluteURL)")!)
                for line in csvData.split(separator: "\n") {
                    let it = TodoItem.parse(csv: String(line))
                    if it != nil {
                        addItem(item: it!)
                    }
                }
            } catch {
                print("Can't load \(file) \(error.localizedDescription)")
            }
        } else {
            print("File \(file) doesn't exists")
        }
    }
}
