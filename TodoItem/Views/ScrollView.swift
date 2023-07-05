//
//  ScrollView.swift
//  TodoItem
//
//  Created by Кира on 01.07.2023.
//

import Foundation
import UIKit

final class ScrollView: UIScrollView {
    private lazy var mainStackView = createMainStackView()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        createScrollView()
        setConstraints()
    }
    
    private func createMainStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.layer.cornerRadius = 16
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.backgroundColor = .white
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }
    
    private func createScrollView() {
        isScrollEnabled = true
//        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainStackView)
    }
    
    func addToMainStackView(subview: UIView) {
        mainStackView.addArrangedSubview(subview)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor, constant: 16),
            mainStackView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor, constant: -34),
            mainStackView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            mainStackView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16)
        ])
    }
}
