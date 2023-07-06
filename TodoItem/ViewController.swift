//
//  ViewController.swift
//  TodoItem
//
//  Created by Кира on 14.06.2023.
//

import UIKit

extension ViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
        saveButton.isEnabled = true
        removeButton.isEnabled = true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholderLabel.isHidden = true
        saveButton.isEnabled = true
        removeButton.isEnabled = true
    }
}

extension ViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let now = Calendar.current.dateComponents(in: .current, from: Date())
        let tomorrow = DateComponents(year: now.year, month: now.month, day: now.day! + 1)
        let dateTomorrow = Calendar.current.date(from: tomorrow)!
        deadlineSelect = (dateComponents?.date)!
        deadlineSelectDate = dateFormatter.string(from: (dateComponents?.date ?? dateTomorrow))
        deadlineLabel.text = "Cделать до \(deadlineSelectDate)"
    }
}

class ViewController: UIViewController {
    
    let cancelButton: UIButton = UIButton(type: .system)
    let saveButton: UIButton = UIButton(type: .system)
    let itemLabel: UILabel = UILabel()
    var itemDescriptionText: UITextView = UITextView(frame: .zero)
    var placeholderLabel: UILabel = UILabel()
    let importanceLabel: UILabel = UILabel()
    var chooseImportanceSegment: UISegmentedControl = UISegmentedControl()
    let deadlineLabel: UILabel = UILabel()
    let dateLabel: UILabel = UILabel()
    var enableDeadlineSwitch: UISwitch = UISwitch()
    var calendarView: UICalendarView = UICalendarView()
    var removeButton: UIButton = UIButton()
    let separator: UIView = UIView()
    let separator2: UIView = UIView()
    
    var deadlineSelectDate: String = ""
    var deadlineSelect: Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareItemView()
        loadFromSaved()
        saveButton.isEnabled = false
        removeButton.isEnabled = false
    
    }
    
    func prepareItemView() {
        self.view.backgroundColor = UIColor(red: 247/255.0, green: 246/255.0, blue: 242/255.0, alpha: 1)
        
        let firstStackView = UIStackView()
        view.addSubview(firstStackView)
        
        firstStackView.translatesAutoresizingMaskIntoConstraints = false
        firstStackView.axis = .horizontal
        firstStackView.distribution = .equalSpacing
        firstStackView.layer.cornerRadius = 16
        firstStackView.sizeToFit()
        
        let secondStackView = UIStackView()
        view.addSubview(secondStackView)
        
        secondStackView.translatesAutoresizingMaskIntoConstraints = false
        secondStackView.axis = .vertical
        secondStackView.distribution = .equalSpacing
        secondStackView.layer.cornerRadius = 16
        secondStackView.layer.masksToBounds = true
        secondStackView.spacing = 0
        
        let importanceStackView = UIStackView()
        view.addSubview(importanceStackView)
        
        importanceStackView.translatesAutoresizingMaskIntoConstraints = false
        importanceStackView.axis = .horizontal
        importanceStackView.distribution = .equalSpacing
        importanceStackView.backgroundColor = .white
        
        let deadlineStackView = UIStackView()
        view.addSubview(deadlineStackView)
        
        deadlineStackView.translatesAutoresizingMaskIntoConstraints = false
        deadlineStackView.axis = .horizontal
        deadlineStackView.distribution = .equalSpacing
        deadlineStackView.backgroundColor = .white
        deadlineStackView.spacing = 16
        deadlineStackView.sizeToFit()
        
        
        cancelButton.setTitle("Отменить", for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: "San Francisco Pro Text", size: 17)
        
        cancelButton.addTarget(self, action: #selector(self.cancelButtonTapped), for: .touchUpInside)
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        saveButton.addTarget(self, action: #selector(self.saveButtonTapped), for: .touchUpInside)
        
        itemLabel.text = "Дело"
        itemLabel.font = UIFont.boldSystemFont(ofSize: 17)
        itemLabel.textColor = .black
        
        firstStackView.addArrangedSubview(cancelButton)
        firstStackView.addArrangedSubview(itemLabel)
        firstStackView.addArrangedSubview(saveButton)
        firstStackView.spacing = 65
        
        NSLayoutConstraint.activate([
            firstStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 17),
            firstStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            firstStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            firstStackView.heightAnchor.constraint(equalToConstant: 56)
        ])

        
        view.addSubview(itemDescriptionText)
        itemDescriptionText.delegate = self
        itemDescriptionText.translatesAutoresizingMaskIntoConstraints = false
        itemDescriptionText.text = ""
        itemDescriptionText.font = UIFont.systemFont(ofSize: 17)
        itemDescriptionText.contentInset = UIEdgeInsets(top: 17, left: 16, bottom: 0, right: 0)
        itemDescriptionText.textColor = .black
        itemDescriptionText.backgroundColor = .white
        itemDescriptionText.layer.cornerRadius = 16
        itemDescriptionText.isScrollEnabled = true
        
        view.addSubview(placeholderLabel)
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.text = "Что надо сделать?"
        placeholderLabel.textColor = .lightGray
        placeholderLabel.font = UIFont(name: "San Francisco Pro Text", size: 17)
        
        NSLayoutConstraint.activate([
            itemDescriptionText.topAnchor.constraint(equalTo: firstStackView.bottomAnchor, constant: 16),
            itemDescriptionText.widthAnchor.constraint(equalTo: firstStackView.widthAnchor),
            itemDescriptionText.heightAnchor.constraint(equalToConstant: 120),
            itemDescriptionText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            itemDescriptionText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            placeholderLabel.leadingAnchor.constraint(equalTo: itemDescriptionText.leadingAnchor, constant: 16),
            placeholderLabel.topAnchor.constraint(equalTo: itemDescriptionText.topAnchor, constant: 17)
        ])
        
        importanceLabel.translatesAutoresizingMaskIntoConstraints = false
        importanceLabel.text = "Важность"
        importanceLabel.font = UIFont(name: "San Francisco Pro Text", size: 17)
        importanceLabel.textAlignment = .center
        importanceLabel.textColor = .black
        
        chooseImportanceSegment.translatesAutoresizingMaskIntoConstraints = false
        chooseImportanceSegment.insertSegment(with: UIImage(named: "lowPriority")?.withTintColor(.gray, renderingMode: .alwaysOriginal), at: 0, animated: true)
        chooseImportanceSegment.insertSegment(withTitle: "нет", at: 1, animated: true)
        chooseImportanceSegment.insertSegment(with: UIImage(named: "highPriority")?.withTintColor(.red, renderingMode: .alwaysOriginal), at: 2, animated: true)
        chooseImportanceSegment.frame.size.height = 36
        chooseImportanceSegment.selectedSegmentIndex = 1
        
        importanceStackView.addArrangedSubview(importanceLabel)
        importanceStackView.addArrangedSubview(chooseImportanceSegment)
        
        NSLayoutConstraint.activate([
            importanceStackView.heightAnchor.constraint(equalToConstant: 56),
            importanceLabel.leadingAnchor.constraint(equalTo: importanceStackView.leadingAnchor, constant: 16),
            importanceLabel.topAnchor.constraint(equalTo: importanceStackView.topAnchor, constant: 16),
            chooseImportanceSegment.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            chooseImportanceSegment.heightAnchor.constraint(equalToConstant: 36),
            chooseImportanceSegment.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        deadlineLabel.translatesAutoresizingMaskIntoConstraints = false
        deadlineLabel.text = "Cделать до"
        deadlineLabel.font = UIFont(name: "San Francisco Pro Text", size: 17)
        deadlineLabel.textAlignment = .center
        deadlineLabel.textColor = .black
        
        enableDeadlineSwitch.translatesAutoresizingMaskIntoConstraints = false
        enableDeadlineSwitch.isOn = false
        
        deadlineStackView.addArrangedSubview(deadlineLabel)
        deadlineStackView.addArrangedSubview(enableDeadlineSwitch)
        
        NSLayoutConstraint.activate([
            deadlineStackView.heightAnchor.constraint(equalToConstant: 56),
            deadlineLabel.leadingAnchor.constraint(equalTo: deadlineStackView.leadingAnchor, constant: 16),
            deadlineLabel.topAnchor.constraint(equalTo: deadlineStackView.topAnchor),
            enableDeadlineSwitch.topAnchor.constraint(equalTo: deadlineStackView.topAnchor, constant: 12.5),
            enableDeadlineSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28)
        ])
        
        view.addSubview(calendarView)
        calendarView.calendar = Calendar(identifier: .gregorian)
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.backgroundColor = .white
        calendarView.availableDateRange = DateInterval(start: .now, end: .distantFuture)
        calendarView.selectionBehavior = UICalendarSelectionSingleDate(delegate: self)
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: deadlineStackView.bottomAnchor)
        ])
        enableDeadlineSwitch.addTarget(self, action: #selector(self.didTapSwitch), for: .touchUpInside)
        view.addSubview(separator)
        separator.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 2)
        separator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        view.addSubview(separator2)
        separator2.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 2)
        separator2.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        secondStackView.addArrangedSubview(importanceStackView)
        secondStackView.addArrangedSubview(separator)
        secondStackView.addArrangedSubview(deadlineStackView)
        secondStackView.addArrangedSubview(separator2)
        secondStackView.addArrangedSubview(calendarView)
        calendarView.isHidden = true
        separator2.isHidden = true
        
        NSLayoutConstraint.activate([
            secondStackView.topAnchor.constraint(equalTo: itemDescriptionText.bottomAnchor, constant: 16),
            secondStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            secondStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
//            separator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            separator2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            separator.leadingAnchor.constraint(equalTo: secondStackView.leadingAnchor, constant: 16),
//            separator2.leadingAnchor.constraint(equalTo: secondStackView.leadingAnchor, constant: 16),
//            separator.trailingAnchor.constraint(equalTo: secondStackView.trailingAnchor, constant: -16),
//            separator2.trailingAnchor.constraint(equalTo: secondStackView.trailingAnchor, constant: -16)
            
        ])
        view.addSubview(removeButton)
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        removeButton.setTitle("Удалить", for: .normal)
        if removeButton.isEnabled {
            removeButton.setTitleColor(UIColor.red, for: .normal)
        } else {
            removeButton.setTitleColor(UIColor.gray, for: .normal)
        }
        removeButton.titleLabel?.font = UIFont(name: "San Francisco Pro Text", size: 17)
        removeButton.backgroundColor = .white
        removeButton.layer.cornerRadius = 16
        removeButton.addTarget(self, action: #selector(self.removeButtonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            removeButton.topAnchor.constraint(equalTo: secondStackView.bottomAnchor, constant: 16),
            removeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            removeButton.widthAnchor.constraint(equalTo: secondStackView.widthAnchor),
            removeButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    @objc func didTapSwitch() {
        if enableDeadlineSwitch.isOn {
            calendarView.isHidden = false
            separator2.isHidden = false
        } else {
            calendarView.isHidden = true
            separator2.isHidden = true
            deadlineLabel.text = "Cделать до"
        }
    }
    
    @objc func datePickerChanged(_ sender: Any) {
        var date = Date()
        date = calendarView.visibleDateComponents.date ?? Date()
        print(date)
    }
    
    func createTodoItem() -> TodoItem {
        let text = itemDescriptionText.text!
        let deadline = deadlineSelect
        let doneFlag = false
        let creationDate = Date()
        let importanceIndex = chooseImportanceSegment.selectedSegmentIndex
        var importance: Importance
        if importanceIndex == 0 {
            importance = Importance.unimportant
        } else if importanceIndex == 1 {
            importance = Importance.normal
        } else {
            importance = Importance.important
        }
        let item = TodoItem(text: text, deadline: deadline, doneFlag: doneFlag, creationDate: creationDate, importance: importance)
        return item
    }
    
    @objc func saveButtonTapped() {
        let item = createTodoItem()
        let fileCache = FileCache()
        fileCache.addItem(item: item)
        fileCache.saveToJson(to: "test")
    }
    
    @objc func removeButtonTapped() {
        let item = createTodoItem()
        let fileCache = FileCache()
        fileCache.removeItem(with: item.id)
        itemDescriptionText.text = ""
        chooseImportanceSegment.selectedSegmentIndex = 1
        enableDeadlineSwitch.isOn = false
        placeholderLabel.isHidden = false
        
    }
    @objc func cancelButtonTapped() {
        itemDescriptionText.text = ""
        chooseImportanceSegment.selectedSegmentIndex = 1
        enableDeadlineSwitch.isOn = false
        placeholderLabel.isHidden = false
        
    }
    
    func loadFromSaved() {
        let path: URL = URL(string: "/Users/kira/Desktop/test.json")!
//        let items = [TodoItem]
        let fileCache = FileCache()
        fileCache.loadFromJson(from: path)
        let firstItem = fileCache.todoItems[0]
        print("lalala ", fileCache.todoItems)
        var importanceIndex: Int
        if fileCache.todoItems.isEmpty != true {
            if firstItem.importance == .normal {
                importanceIndex = 1
            } else if firstItem.importance == .unimportant {
                importanceIndex = 0
            } else {
                importanceIndex = 2
            }
            placeholderLabel.isHidden = true
            itemDescriptionText.text = firstItem.text
            chooseImportanceSegment.selectedSegmentIndex = importanceIndex
        }
    }

}

