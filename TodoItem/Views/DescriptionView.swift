//
//  DescriptionView.swift
//  TodoItem
//
//  Created by Кира on 01.07.2023.
//

import Foundation
import UIKit

final class DescriptionView: UITextView {
    required init?(coder: NSCoder) {
        nil
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        createDescriptionTextView()
    }
    
    private lazy var placeholderLabel = UILabel()
    
    private func createDescriptionTextView() {
            frame = CGRect(x: 0, y: 0, width: 343, height: 120)
            delegate = self
            translatesAutoresizingMaskIntoConstraints = false
            text = "Что надо сделать?"
            textColor = .lightGray
            font = UIFont.systemFont(ofSize: 17)
            contentInset = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
            heightAnchor.constraint(greaterThanOrEqualToConstant: 120).isActive = true
            invalidateIntrinsicContentSize()
            textColor = .black
            backgroundColor = .white
            layer.cornerRadius = 16
            isScrollEnabled = true
    }
    
    func setText(textAdd: String) {
        text = textAdd
    }
    
    func getText() -> String {
        return text
    }
}


extension DescriptionView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholderLabel.isHidden = true
    }
}
