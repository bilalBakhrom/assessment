//
//  TextFieldWrapper.swift
//
//
//  Created by Bilal Bakhrom on 2024-02-02.
//

import SwiftUI

public struct TextFieldWrapper: UIViewRepresentable {
    @Binding public var text: String
    @Binding public var isActive: Bool
    public var onSubmit: (() -> Void)?
    public var placeholder: String
    
    public init(_ placeholder: String = "", text: Binding<String>, isActive: Binding<Bool>, onSubmit: (() -> Void)? = nil) {
        _text = text
        _isActive = isActive
        self.placeholder = placeholder
        self.onSubmit = onSubmit
    }
    
    public func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 15, weight: .medium)
        textField.textColor = .modulePrimaryLabel
        textField.delegate = context.coordinator
        textField.returnKeyType = .search
        textField.backgroundColor = .clear
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .font: UIFont.systemFont(ofSize: 15),
                .foregroundColor: UIColor.moduleGray
            ]
        )
        
        return textField
    }
    
    public func updateUIView(_ uiView: UITextField, context: Context) {
        DispatchQueue.main.async {
            uiView.text = text
            
            if isActive && !uiView.isFirstResponder {
                uiView.becomeFirstResponder()
            } else if !isActive && uiView.isFirstResponder {
                uiView.resignFirstResponder()
            }
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public class Coordinator: NSObject, UITextFieldDelegate {
        public var parent: TextFieldWrapper
        
        public init(_ parent: TextFieldWrapper) {
            self.parent = parent
        }
        
        public func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
        
        public func textFieldDidBeginEditing(_ textField: UITextField) {
            parent.isActive = true
        }
        
        public func textFieldDidEndEditing(_ textField: UITextField) {
            parent.isActive = false
        }
        
        public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            parent.onSubmit?()
            return true
        }
    }
}

