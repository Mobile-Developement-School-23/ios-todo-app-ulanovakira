//
//  TodoItemView.swift
//  TodoItem
//
//  Created by Кира on 29.06.2023.
//

import Foundation
import UIKit

class TodoItemViewController: UIViewController, UICalendarViewDelegate {
    private let importanceView = ImportanceView()
    private let deadlineView = DeadlineView()
    private let calendarView = CalendarView()
    private let separatorView = SeparatorView()
    private let separatorView2 = SeparatorView()
    private let scrollView = ScrollView()
    private let removeButton = RemoveButtonView()
    private var itemStackView = ItemStackView()
    private let descriptionView = DescriptionView()
    
    let fileCache = FileCache()
    var todoItem: TodoItem?
    
    override func loadView() {
        super.loadView()
        itemStackView = ItemStackView(arrangedSubviews: [importanceView, separatorView, deadlineView, separatorView2, calendarView])
        calendarView.isHidden = true
        separatorView2.isHidden = true
        view.addSubview(scrollView)
        
        scrollView.addToMainStackView(subview: descriptionView)
        scrollView.addToMainStackView(subview: itemStackView)
        scrollView.addToMainStackView(subview: removeButton)
        
        setConstraints()
        
        deadlineView.delegate = self
        calendarView.delegate = self
        
        let path: URL = URL(string: "/Users/kira/Desktop/test.json")!
        fileCache.loadFromJson(from: path)
        if !fileCache.todoItems.isEmpty {
            todoItem = fileCache.todoItems[0]
            descriptionView.setText(textAdd: todoItem!.text)
            importanceView.setImportance(importanceNew: todoItem!.importance)
            if todoItem!.deadline != nil {
                deadlineView.setSwitchOn()
                calendarView.setDeadline(date: todoItem!.deadline!)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNabigationBar()
        view.backgroundColor = UIColor(red: 247/255.0, green: 246/255.0, blue: 242/255.0, alpha: 1)
        removeButton.isUserInteractionEnabled = true
        removeButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)
        ])
    }
    
    func createTodoItem() -> TodoItem {
        let text = descriptionView.getText()
        var deadline: Date? = nil
        if deadlineView.isSwitchOn() {
            deadline = calendarView.getDeadline()
        }
        let doneFlag = false
        let creationDate = Date()
        let importance = importanceView.getImportance()
        let item = TodoItem(text: text, deadline: deadline, doneFlag: doneFlag, creationDate: creationDate, importance: importance)
        return item
    }
    
    func saveItem() {
        fileCache.addItem(item: createTodoItem())
        fileCache.saveToJson(to: "test1")
    }
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func saveButtonTapped() {
        saveItem()
      }
    @objc func removeButtonTapped() {
        if todoItem != nil {
            fileCache.removeItem(with: todoItem!.id)
            fileCache.saveToJson(to: "test1")
        }
      }
    @objc func dateButtonTapped() {
        if calendarView.isHidden == true {
            calendarView.isHidden = false
            separatorView2.isHidden = false
        } else {
            calendarView.isHidden = true
            separatorView2.isHidden = true
        }
    }
    
}

extension TodoItemViewController {
    private func createNabigationBar() {
        let cancelButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem = cancelButton
        
        let saveButton = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
        
        let attributes: [NSAttributedString.Key:Any] = [.font: UIFont.boldSystemFont(ofSize: 17)]
        
        saveButton.setTitleTextAttributes(attributes, for: .normal)
        saveButton.setTitleTextAttributes(attributes, for: .disabled)
        saveButton.setTitleTextAttributes(attributes, for: .highlighted)
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.shadowColor = nil
        navigationBarAppearance.backgroundColor = nil
        saveButton.isEnabled = false
    }
}
