//
//  ImportanceView.swift
//  TodoItem
//
//  Created by Кира on 30.06.2023.
//

import Foundation
import UIKit

final class ImportanceView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        createImportanceView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private lazy var importanceLabel = getImportanceLabel()
    private lazy var chooseImportanceSegment = getImportanceSegment()
    var importance = Importance.normal
    func createImportanceView() {
        axis = .horizontal
        backgroundColor = .white
        alignment = .center
        translatesAutoresizingMaskIntoConstraints = false
        distribution = .equalSpacing
        addArrangedSubview(importanceLabel)
        addArrangedSubview(chooseImportanceSegment)
    }
    
    func setImportance(importanceNew: Importance) {
        importance = importanceNew
        if importance == .normal {
            chooseImportanceSegment.selectedSegmentIndex = 1
        } else if importance == .unimportant {
            chooseImportanceSegment.selectedSegmentIndex = 0
        } else {
            chooseImportanceSegment.selectedSegmentIndex = 2
        }
    }
    
    func getImportance() -> Importance {
        if chooseImportanceSegment.selectedSegmentIndex == 0 {
            importance = .unimportant
        } else if chooseImportanceSegment.selectedSegmentIndex == 1 {
            importance = .normal
        } else {
                importance = .important
        }   
        return importance
    }
    
    private func getImportanceLabel() -> UILabel {
        let importanceLabel: UILabel = UILabel()
        importanceLabel.text = "Важность"
        importanceLabel.font = UIFont(name: "San Francisco Pro Text", size: 17)
        importanceLabel.textAlignment = .center
        importanceLabel.textColor = .black
        
        return importanceLabel
    }
    
    private func getImportanceSegment() -> UISegmentedControl {
        let chooseImportanceSegment: UISegmentedControl = UISegmentedControl()
        chooseImportanceSegment.insertSegment(with: UIImage(named: "lowPriority")?.withTintColor(.gray, renderingMode: .alwaysOriginal), at: 0, animated: true)
        chooseImportanceSegment.insertSegment(withTitle: "нет", at: 1, animated: true)
        chooseImportanceSegment.insertSegment(with: UIImage(named: "highPriority")?.withTintColor(.red, renderingMode: .alwaysOriginal), at: 2, animated: true)
        chooseImportanceSegment.frame.size.height = 36
        chooseImportanceSegment.frame.size.width = 150
        chooseImportanceSegment.selectedSegmentIndex = 1
        chooseImportanceSegment.translatesAutoresizingMaskIntoConstraints = false
        
        return chooseImportanceSegment
    }
    
    
}
