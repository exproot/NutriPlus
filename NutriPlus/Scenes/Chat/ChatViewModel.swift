//
//  ChatViewModel.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 23.12.2024.
//

import Foundation

final class ChatViewModel {
  @Published var messages: [Message] = []
  private let geminiService: GeminiService

  init(geminiService: GeminiService) {
    self.geminiService = geminiService
  }

  func sendMessage(_ text: String) {
    let userMessage = Message(text: text, isSentByUser: true)
    messages.append(userMessage)

    geminiService.getResponse(text, history: messages) { [weak self] result in
      switch result {
      case .success(let response):
        let aiMessage = Message(text: response, isSentByUser: false)
        DispatchQueue.main.async {
          self?.messages.append(aiMessage)
        }
      case .failure(let error):
        let errorMessage = Message(text: "Failed to get response. Try again.", isSentByUser: false)
        DispatchQueue.main.async {
          self?.messages.append(errorMessage)
        }
      }
    }
  }
}
