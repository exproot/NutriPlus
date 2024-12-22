//
//  AIInstructions.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 22.12.2024.
//

import Foundation

enum AIInstructions {
  static let mealIdentification = """
  You have to identify the meal in the given image.
  The system should accurately detect meal which displayed in the
  image, providing the name of the food, total calories of the meal,
  its type(breakfast, dinner or snack) and total proteins, carbs and
  fats in grams. Use this JSON format as an blueprint. Give me pure JSON.
  {
    “name”: “Name of the meal. string type",
    “detail”: “Give short comments about the meal like you're a nutritionist, maximum 150 characters. string type”,
    “calories”: “Total calorie amount of the meal in kcal. number type.”,
    "type": "Type of the meal, must be one of these: breakfast, dinner, snack. string type"
    “nutrients”: {
      “protein”: “Total amount of protein in the meal (grams). number type“,
      “fats”: "Total amount of fats in the food (grams). number type,
      “carbs”: "Total amount of carbs in the food (grams). number type"
    }
  }
  """
}
