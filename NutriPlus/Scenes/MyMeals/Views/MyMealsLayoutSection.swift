//
//  MyMealsLayoutSection.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 7.11.2024.
//

import UIKit

struct MyMealsLayoutSection {
    static func createLayoutSection(for sectionIdentifier: MyMealsViewModel.Section) -> NSCollectionLayoutSection? {
        switch sectionIdentifier {
        case .main:
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.22), heightDimension: .fractionalHeight(1)))
            item.contentInsets.leading = 10
            item.contentInsets.trailing = 10
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.13)), subitem: item, count: 4)
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            
            return section
        case .meals:
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets = .init(top: 10, leading: 15, bottom: 10, trailing: 15)
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.25)), subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.top = 16
            return section
        }
    }
}
