//
//  GeminiService.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 22.12.2024.
//

import Foundation
import GoogleGenerativeAI

final class GeminiService {
  weak var delegate: GeminiServiceDelegate?
  private var model: GenerativeModel?

  func getResponse(for imageData: Data) {
    let apiKey = Bundle.main.infoDictionary?["GEMINI_API_KEY"] as? String ?? ""
    model = GenerativeModel(
      name: "gemini-1.5-flash",
      apiKey: apiKey,
      systemInstruction: AIInstructions.mealIdentification
    )

    delegate?.geminiServiceDidStartGeneratingResponse(self)

    Task { [weak self] in
      guard let self = self, let model = model else { return }
      do {
        let response = try await model.generateContent("do your instruction", ModelContent.Part.jpeg(imageData))
        guard let text = response.text else { return }

        let cleanedString = text
          .replacingOccurrences(of: "```", with: "")
          .replacingOccurrences(of: "json", with: "")

        let data = cleanedString.data(using: .utf8)
        self.delegate?.geminiService(didGenerateResponse: data)
      } catch {
        self.delegate?.geminiService(didFailWithError: error)
      }
    }
  }
}
