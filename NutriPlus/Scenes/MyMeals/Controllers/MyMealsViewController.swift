//
//  MyMealsViewController.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 7.11.2024.
//

import UIKit

final class MyMealsViewController: UIViewController {
    private let viewModel = MyMealsViewModel()
    private var dataSource: UICollectionViewDiffableDataSource<MyMealsViewModel.Section, MyMealsViewModel.Row>!
    
    // MARK: - UI Components
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        cv.backgroundColor = .systemBackground
        cv.register(CalendarCell.self, forCellWithReuseIdentifier: CalendarCell.identifier)
        cv.register(MealCell.self, forCellWithReuseIdentifier: MealCell.identifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        setupUI()
        viewModel.viewDidLoad()
        configureDataSource()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionView.selectItem(at: IndexPath(item: viewModel.selectedDateIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { [weak self] (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionIdentifier = self?.dataSource.snapshot().sectionIdentifiers[sectionIndex] else { return nil }
            
            return MyMealsLayoutSection.createLayoutSection(for: sectionIdentifier)
        }
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch item {
            case .calendar(let model):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCell.identifier, for: indexPath) as? CalendarCell else { fatalError() }
                cell.configure(day: model.day, month: model.month)
                return cell
            case .meal(let model):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealCell.identifier, for: indexPath) as? MealCell else { fatalError() }
                cell.configure(with: model.text)
                return cell
            }
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<MyMealsViewModel.Section, MyMealsViewModel.Row>()
        snapshot.appendSections([.main, .meals])
        snapshot.appendItems(viewModel.testCalendarItems, toSection: .main)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        title = "My Meals"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension MyMealsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CalendarCell else { return }

        switch indexPath.section {
        case 0:
            viewModel.selectedDateIndex = indexPath.item
            viewModel.prepareTestMeals(for: cell.dayNumberLabel.text)
            
            var snapshot = NSDiffableDataSourceSnapshot<MyMealsViewModel.Section, MyMealsViewModel.Row>()
            snapshot.appendSections([.main, .meals])
            snapshot.appendItems(viewModel.testCalendarItems, toSection: .main)
            snapshot.appendItems(viewModel.testMealItems, toSection: .meals)
            
            dataSource.apply(snapshot, animatingDifferences: true)
        case 1:
            // TODO: - Handle meal tapping.
            return
        default:
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        viewModel.selectedDateIndex = indexPath.item
    }
}
