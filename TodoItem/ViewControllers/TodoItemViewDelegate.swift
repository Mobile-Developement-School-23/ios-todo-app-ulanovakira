//
//  TodoItemViewDelegate.swift
//  TodoItem
//
//  Created by Кира on 30.06.2023.
//

import Foundation
import UIKit

extension TodoItemViewController: UITextViewDelegate {
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

extension DeadlineView: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let now = Calendar.current.dateComponents(in: .current, from: Date())
        let tomorrow = DateComponents(year: now.year, month: now.month, day: now.day! + 1)
        let dateTomorrow = Calendar.current.date(from: tomorrow)!
        deadlineSelect = (dateComponents?.date)!
        deadlineSelectDate = dateFormatter.string(from: (dateComponents?.date ?? dateTomorrow))
        dateButton.setTitle("deadlineSelectDate", for: .normal)
    }
}
