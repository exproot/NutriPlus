//
//  HomeViewModel.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 2.01.2025.
//

import Foundation
import Combine

final class HomeViewModel {
  let authService: AuthServiceProtocol
  let assessmentService: AssessmentServiceProtocol
  let mealService: MealServiceProtocol
  private var bmrCalculationStrategy: BMRCalculationStrategy
  private var cancellables: Set<AnyCancellable> = []

  private(set) var userHealthData: AssessmentModel?
  private(set) var bmiValue: Double = 0.0
  private(set) var bmrValue: Double = 0.0
  private(set) var bmiCategory: BMICategory = .obese
  private(set) var targetCalorie: Double = 0.0
  private(set) var caloriesConsumedToday: Int = 0
  private(set) var progressValue: Double = 0.0
  private(set) var calorieGoalText: String = "Wait..."
  private(set) var meals: [MealCellViewModel] = []

  @Published var dateText: String = ""
  @Published var greetingText: String = ""
  @Published var userImageString: String = ""
  @Published var calorieGoalCellViewModel: CalorieGoalCellViewModel?
  @Published var bmrConditionCellViewModel: ConditionCellViewModel?
  @Published var bmiConditionCellViewModel: ConditionCellViewModel?

  var reloadMealsSubject = PassthroughSubject<Void, Never>()

  init(authService: AuthServiceProtocol, assessmentService: AssessmentServiceProtocol, mealService: MealServiceProtocol, strategy: BMRCalculationStrategy) {
    self.authService = authService
    self.assessmentService = assessmentService
    self.mealService = mealService
    self.bmrCalculationStrategy = strategy
    updateUserInfo()
    fetchUserAssessmentData()

    reloadMealsSubject
      .flatMap { [weak self] _ -> AnyPublisher<Bool, Never> in
        guard let self = self else { return Just(false).eraseToAnyPublisher() }
        return self.fetchMealsPublisher()
      }
      .sink { [weak self] _ in
        guard let self = self, let userAssessmentData = self.userHealthData else { return }
        self.calculateTargetCalories(for: userAssessmentData)
        self.calculateProgressValue()
        self.updateCalorieGoalText()
        self.updateCalorieCell()
      }
      .store(in: &cancellables)
  }

  private func updateUserInfo() {
    dateText = Date().toFormattedString(format: "MMM d, yyyy")

    if let currentUser = authService.getCurrentUser(), let email = currentUser.email {
      let namePart = (email.split(separator: "@").first)?.lowercased()
      greetingText = "Welcome, \n\(namePart ?? "N/a")"
      userImageString = "\(namePart?.first?.description ?? "a").circle.fill"
    }
  }

  private func fetchMealsPublisher() -> AnyPublisher<Bool, Never> {
    Future { [weak self] promise in
      self?.fetchMeals { success in
        promise(.success(success))
      }
    }
    .eraseToAnyPublisher()
  }

  func reloadMeals() {
    reloadMealsSubject.send()
  }

  private func fetchUserAssessmentData() {
    assessmentService.fetchAssessmentData { [weak self] result in
      switch result {
      case .success(let model):
        self?.userHealthData = model
        self?.calculateBMI(for: model)
        self?.calculateBMR(for: model)
        self?.updateBMIConditionCell()
        self?.updateBMRConditionCell()
      case .failure(let error):
        print(error)
      }
    }
  }

  private func fetchMeals(completion: @escaping (Bool) -> Void) {
    mealService.fetchMeals(dateString: Date().toFormattedString()) { [weak self] result in
      switch result {
      case .success(let meals):
        self?.meals = meals
        self?.caloriesConsumedToday = meals.reduce(0) { $0 + $1.calories }
        completion(true)
      case .failure:
        self?.caloriesConsumedToday = 0
        completion(false)
      }
    }
  }

  private func calculateBMI(for assessment: AssessmentModel) {
    guard let weight = assessment.weight, let height = assessment.heightInMeters else { return }

    bmiValue = BMICalculator.calculateBMI(height: Double(height), weight: Double(weight))
    bmiCategory = BMICalculator.classifyBMI(bmiValue)
  }

  private func calculateBMR(for assessment: AssessmentModel) {
    guard
      let weight = assessment.weight,
      let height = assessment.height,
      let age = assessment.age,
      let gender = assessment.gender
    else {
      return
    }

    bmrValue = bmrCalculationStrategy.calculateBMR(
      weight: Double(weight),
      height: Double(height),
      age: Double(age),
      gender: gender
    )

    reloadMealsSubject.send()
  }

  private func calculateTargetCalories(for assessment: AssessmentModel) {
    guard let fitLevel = assessment.fitLevel else { return }
    let activityLevel = ActivityLevel(rawValue: fitLevel) ?? .sedentary
    let goal: Goal

    switch bmiCategory {
    case .underweight:
      goal = .bulk
    case .normal:
      goal = .maintain
    case .overweight:
      goal = .cut
    case .obese:
      goal = .cut
    }

    targetCalorie = TargetCalorieCalculator.calculateTargetCalories(bmr: bmrValue, activityLevel: activityLevel, goal: goal)
  }

  private func calculateProgressValue() {
    let ratio = targetCalorie > 0 ? Double(caloriesConsumedToday) / targetCalorie : 0.0
    progressValue = max(0, min(ratio, 1.0))
  }

  private func updateCalorieGoalText() {
    calorieGoalText = "\(caloriesConsumedToday)/\(targetCalorie.formatted) kcal"
  }

  private func updateCalorieCell() {
      calorieGoalCellViewModel = CalorieGoalCellViewModel(title: calorieGoalText, progressValue: progressValue)
  }

  private func updateBMIConditionCell() {
    bmiConditionCellViewModel = ConditionCellViewModel(title: "BMI: \(bmiValue.formatted) (\(bmiCategory.rawValue))", colors: bmiCategory.colors)
  }

  private func updateBMRConditionCell() {
    bmrConditionCellViewModel = ConditionCellViewModel(title: "BMR: \(bmrValue.formatted) kcal", colors: [.systemBlue, .systemCyan])
  }
}
