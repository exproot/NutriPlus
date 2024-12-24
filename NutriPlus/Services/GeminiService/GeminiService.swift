//
//  GeminiService.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 22.12.2024.
//

import Foundation
import GoogleGenerativeAI

enum GeminiError: Error, LocalizedError {
  case unknown

  var errorDescription: String? {
    switch self {
    case .unknown:
      return "Hello"
    }
  }
}

final class GeminiService {
  weak var imageScanDelegate: GeminiImageDelegate?
  private var model: GenerativeModel?
  

  func getResponse(_ message: String, history: [Message], completion: @escaping (Result<String, Error>) -> Void) {
    let apiKey = Bundle.main.infoDictionary?["GEMINI_API_KEY"] as? String ?? ""
    model = GenerativeModel(name: "gemini-1.5-flash", apiKey: apiKey, systemInstruction: AIInstructions.mealDetails)
    guard let model = model else { return }

    let chatHistory = history.map { message in
      ModelContent(role: message.isSentByUser ? "user" : "model", parts: message.text)
    }

    let chat = model.startChat(history: chatHistory)

    Task {
      do {
        let response = try await chat.sendMessage(message)

        if let aiResponse = response.text {
          DispatchQueue.main.async {
            completion(.success(aiResponse))
          }
        } else {
          DispatchQueue.main.async {
            completion(.failure(GeminiError.unknown))
          }
        }
      } catch {
        DispatchQueue.main.async {
          completion(.failure(error))
        }
      }
    }
  }

  func getResponse(for imageData: Data) {
    let apiKey = Bundle.main.infoDictionary?["GEMINI_API_KEY"] as? String ?? ""
    model = GenerativeModel(
      name: "gemini-1.5-flash",
      apiKey: apiKey,
      systemInstruction: AIInstructions.mealIdentification
    )

    imageScanDelegate?.geminiServiceDidStartGeneratingResponse(self)

    Task { [weak self] in
      guard let self = self, let model = model else { return }
      do {
        let response = try await model.generateContent("do your instruction", ModelContent.Part.jpeg(imageData))
        guard let text = response.text else { return }

        let cleanedString = text
          .replacingOccurrences(of: "```", with: "")
          .replacingOccurrences(of: "json", with: "")

        let data = cleanedString.data(using: .utf8)
        self.imageScanDelegate?.geminiService(didGenerateResponse: data)
      } catch {
        self.imageScanDelegate?.geminiService(didFailWithError: error)
      }
    }
  }
}
