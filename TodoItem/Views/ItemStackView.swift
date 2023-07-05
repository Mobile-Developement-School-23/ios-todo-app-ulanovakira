//
//  ItemView.swift
//  TodoItem
//
//  Created by Кира on 01.07.2023.
//

import Foundation
import UIKit

final class ItemStackView: UIStackView {
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createItemStackView()
    }
    
    private func createItemStackView() {
        axis = .vertical
        layer.cornerRadius = 16
        backgroundColor = .white
        isLayoutMarginsRelativeArrangement = true
        spacing = 10
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 8, trailing: 14)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
