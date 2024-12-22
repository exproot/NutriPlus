//
//  GeminiServiceDelegate.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 22.12.2024.
//

import Foundation

protocol GeminiServiceDelegate: AnyObject{
  func geminiService(didGenerateResponse data: Data?)
  func geminiService(didFailWithError error: Error)
  func geminiServiceDidStartGeneratingResponse(_ geminiService: GeminiService)
}
