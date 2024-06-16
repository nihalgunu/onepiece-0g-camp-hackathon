//
//  ViewController.swift
//  Usopp
//
//  Created by David Slakter on 6/14/24.
//

import UIKit

class ViewController: UIViewController {

        var responseIndex = 0
        let networkManager = NetworkManager()

        private let chatTextView: UITextView = {
            let textView = UITextView()
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.isEditable = false
            textView.font = UIFont.systemFont(ofSize: 16)
            return textView
        }()

        private let inputTextField: UITextField = {
            let textField = UITextField()
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.borderStyle = .roundedRect
            textField.placeholder = "Type your message..."
            return textField
        }()

        private let sendButton: UIButton = {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Send", for: .normal)
            return button
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            setupViews()
            setupConstraints()
            
            sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        }

        private func setupViews() {
            view.backgroundColor = .white
            view.addSubview(chatTextView)
            view.addSubview(inputTextField)
            view.addSubview(sendButton)
        }

        private func setupConstraints() {
            NSLayoutConstraint.activate([
                chatTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                chatTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                chatTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                chatTextView.bottomAnchor.constraint(equalTo: inputTextField.topAnchor, constant: -16),
                
                inputTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                inputTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -8),
                inputTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
                
                sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                sendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
                sendButton.widthAnchor.constraint(equalToConstant: 80)
            ])
        }
    
        func removeLineContaining(textToRemove: String) {
            guard var currentText = chatTextView.text else {
                return
            }
            
            // Split the current text into an array of lines
            var lines = currentText.components(separatedBy: "\n")
            
            // Find the index of the line containing the text to remove
            if let indexToRemove = lines.firstIndex(where: { $0.contains(textToRemove) }) {
                // Remove the line from the array
                lines.remove(at: indexToRemove)
                
                // Join the remaining lines into a single string with newline characters
                currentText = lines.joined(separator: "\n")
                
                // Update the text view with the modified text
                chatTextView.text = currentText
            }
        }

        @objc private func sendButtonTapped() {
            guard let userInput = inputTextField.text, !userInput.isEmpty else { return }
            appendToChat(sender: "You", text: "\(userInput)")
            inputTextField.text = ""
            appendToChat(sender: "Bot", text: "Thinking...")
            sendButton.isEnabled = false
            networkManager.sendMessage(message: userInput) { [weak self] result in
                DispatchQueue.main.async { [weak self] in
                    if let result, let second_response = result.response2 {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        if let popUpVC = storyboard.instantiateViewController(withIdentifier: "popup") as? FeedbackVC {
                            popUpVC.res1 = result.response1
                            popUpVC.res2 = second_response
                            popUpVC.onDismiss = { [weak self] res in
                                self?.updateResponse(result: res)
                            }
                            self?.present(popUpVC, animated: true)
                        }
                        
                    } else {
                        self?.updateResponse(result: result?.response1)
                    }
                }
            }
        }
    
        private func updateResponse(result: String?) {
            removeLineContaining(textToRemove: "Thinking...")
            if let result {
                printResponseWithDelay(response: result)
            } else {
                printResponseWithDelay(response: "Error: Unable to get response")
            }
            sendButton.isEnabled = true
        }
    
        private func delayThenRespond(_ res: String) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
                self?.removeLineContaining(textToRemove: "Thinking...")
                self?.printResponseWithDelay(response: res)
                self?.sendButton.isEnabled = true
            }
        }

        private func appendToChat(sender: String, text: String) {
            self.chatTextView.text = self.chatTextView.text + "\(sender): " + text + "\n"
        }
    
        private func printResponseWithDelay(response: String) {
            var index = 0
            Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
                guard index < response.count else {
                    timer.invalidate()
                    return
                }
                let character = response[response.index(response.startIndex, offsetBy: index)]
                if index == 0{
                    self.chatTextView.text = self.chatTextView.text + "Bot: " + String(character)
                } else if index == response.count-1 {
                    self.chatTextView.text = self.chatTextView.text + String(character) + "...\n"
                } else {
                    self.chatTextView.text = self.chatTextView.text + String(character)
                }
                index += 1
            }
        }
}

