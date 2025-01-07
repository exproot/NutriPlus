//
//  HomeSectionProvider.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 2.01.2025.
//

import UIKit

enum HomeSectionProvider {
  static func createLayoutSection(for sectionIndex: Int) -> NSCollectionLayoutSection? {
    switch sectionIndex {
    case 0:
      return createSection(height: 0.28, orthogonalScrolling: false)
    case 1:
      return createSection(height: 0.17, orthogonalScrolling: true, isScalable: true)
    case 2:
      return createSection(height: 0.25, orthogonalScrolling: false)
    default:
      return nil
    }
  }

  private static func createSection(height: CGFloat, orthogonalScrolling: Bool, isScalable: Bool = false) -> NSCollectionLayoutSection {
    let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))

    let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(height)), subitems: [item])
    group.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)

    let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(0.75), heightDimension: .fractionalHeight(0.07)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
    header.contentInsets.leading = 20

    let section = NSCollectionLayoutSection(group: group)
    section.boundarySupplementaryItems = [header]

    if orthogonalScrolling {
      section.orthogonalScrollingBehavior = .paging
    }

    if isScalable {
      section.visibleItemsInvalidationHandler = { (items, offset, environment) in
        items.forEach { item in
          if item.representedElementCategory != .supplementaryView {
            let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
            let minScale: CGFloat = 0.8
            let maxScale: CGFloat = 1.0
            let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)

            item.transform = CGAffineTransform(scaleX: scale, y: scale)
          }
        }
      }
    }

    return section
  }
}
