//
//  MyMealsSectionProvider.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 19.12.2024.
//

import UIKit

struct MyMealsSectionProvider {
  static func createLayoutSection(for sectionIndex: Int) -> NSCollectionLayoutSection? {
    switch sectionIndex {
    case 0:
      let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.22), heightDimension: .fractionalHeight(1)))
      item.contentInsets.leading = 10
      item.contentInsets.trailing = 10

      let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.13)), subitem: item, count: 4)

      let section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = .continuous

      return section
    case 1:
      let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
      item.contentInsets = .init(top: 10, leading: 15, bottom: 10, trailing: 15)

      let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.32)), subitems: [item])

      let section = NSCollectionLayoutSection(group: group)
      section.contentInsets.top = 16
      return section
    default:
      return nil
    }
  }
}
