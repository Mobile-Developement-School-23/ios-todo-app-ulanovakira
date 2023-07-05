//
//  RemoveButtonView.swift
//  TodoItem
//
//  Created by Кира on 01.07.2023.
//

import Foundation
import UIKit

final class RemoveButtonView: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        createRemoveButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createRemoveButton() {
        titleLabel?.font = UIFont(name: "San Francisco Pro Text", size: 17)
        backgroundColor = .white
        layer.cornerRadius = 16
        setTitleColor(.lightGray, for: .disabled)
        setTitleColor(.red, for: .normal)
        widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
        heightAnchor.constraint(equalToConstant: 56).isActive = true
    }
}
