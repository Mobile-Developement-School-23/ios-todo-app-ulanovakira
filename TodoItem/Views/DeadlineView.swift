//
//  DeadlineView.swift
//  TodoItem
//
//  Created by Кира on 30.06.2023.
//

import Foundation
import UIKit

final class DeadlineView: UIStackView {
    
    private lazy var deadlineLabel = getDeadlineLabel()
    private lazy var enableDeadlineSwitch = getEnableDeadlineSwitch()
    var delegate: TodoItemViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createDeadlineView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    private func getDeadlineLabel() -> UILabel {
        let deadlineLabel: UILabel = UILabel()
        deadlineLabel.text = "Cделать до"
        deadlineLabel.font = UIFont(name: "San Francisco Pro Text", size: 17)
        deadlineLabel.textAlignment = .center
        deadlineLabel.textColor = .black
        
        return deadlineLabel
    }
    
    private func getEnableDeadlineSwitch() -> UISwitch {
        let enableDeadlineSwitch: UISwitch = UISwitch()
        enableDeadlineSwitch.isOn = false
        enableDeadlineSwitch.addTarget(self, action: #selector(didTapSwitch(_:)), for: .valueChanged)
        return enableDeadlineSwitch
        
    }

    func createDeadlineView() {
        addArrangedSubview(deadlineLabel)
        addArrangedSubview(enableDeadlineSwitch)
        axis = .horizontal
        distribution = .equalSpacing
        backgroundColor = .white
        spacing = 16
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func isSwitchOn() -> Bool {
        return enableDeadlineSwitch.isOn
    }
    
    func setSwitchOn() {
        enableDeadlineSwitch.setOn(true, animated: true)
    }
    

}

extension DeadlineView {
    private var dateButton: UIButton { return createDateButton() }
    private var dateStackView: UIStackView { return createDateStackView() }
    
    var createDeadlineString: String {
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: .now)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
    
        return dateFormatter.string(from: tomorrow)
    }
    private func createDateStackView() -> UIStackView {
        let dateStackView: UIStackView = UIStackView()
        dateStackView.axis = .vertical
        dateStackView.backgroundColor = .white
        dateStackView.spacing = 0
        dateStackView.translatesAutoresizingMaskIntoConstraints = false
        dateStackView.addArrangedSubview(deadlineLabel)
        dateStackView.addArrangedSubview(dateButton)
        
        return dateStackView
    }
    
    private func createDateButton() -> UIButton {
        let dateButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 248, height: 18))
        dateButton.translatesAutoresizingMaskIntoConstraints = false
        dateButton.titleLabel?.textAlignment = .left
        dateButton.titleLabel?.text = createDeadlineString
        dateButton.titleLabel?.font = UIFont(name: "San Francisco Pro Text", size: 13)
        dateButton.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
        
        return dateButton
    }
    
    private func removeSubviews(from stackView: UIStackView) {
        for subview in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }
    
    @objc func didTapSwitch(_ sender: UISwitch) {
        if sender.isOn {
            removeSubviews(from: self)
            addArrangedSubview(dateStackView)
            addArrangedSubview(enableDeadlineSwitch)
//            showValendarView()
        } else {
            removeSubviews(from: self)
            createDeadlineView()
        }
    }
    
    @objc func dateButtonTapped() {
        delegate?.dateButtonTapped()
    }
}

extension DeadlineView: UICalendarViewDelegate {
    private var calendarView: CalendarView {
        return CalendarView(frame: CGRect(x: 0, y: 0, width: 311, height: 312))
    }
    private func showValendarView() {
        dateStackView.addArrangedSubview(calendarView)
    }
}
