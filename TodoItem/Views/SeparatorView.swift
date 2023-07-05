//
//  SeparatorView.swift
//  TodoItem
//
//  Created by Кира on 30.06.2023.
//

import Foundation
import UIKit

final class SeparatorView: UIView {
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .lightGray
        heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
