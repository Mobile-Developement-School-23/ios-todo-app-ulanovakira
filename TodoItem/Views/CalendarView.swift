//
//  CalendarView.swift
//  TodoItem
//
//  Created by Кира on 30.06.2023.
//

import Foundation
import UIKit

final class CalendarView: UICalendarView, UICalendarViewDelegate {
    private var deadlineSelect = Date()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCalendarView()
        let selection = UICalendarSelectionSingleDate(delegate: self)
        selectionBehavior = selection
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func setDeadline(date: Date) {
        deadlineSelect = date
    }
    func getDeadline() -> Date {
        return deadlineSelect
    }
    private func createCalendarView() {
        calendar = Calendar(identifier: .gregorian)
        translatesAutoresizingMaskIntoConstraints = false
        availableDateRange = DateInterval(start: .now, end: .distantFuture)
        backgroundColor = .white
        delegate = self
    }
    
}

extension CalendarView: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
//        let now = Calendar.current.dateComponents(in: .current, from: Date())
//        let tomorrow = DateComponents(year: now.year, month: now.month, day: now.day! + 1)
//        let dateTomorrow = Calendar.current.date(from: tomorrow)!
        deadlineSelect = (dateComponents?.date)!
    }
}
