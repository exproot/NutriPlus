//
//  MainTabBarShapeLayer.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 8.01.2025.
//

import UIKit

extension MainTabBarController {
  func setupTabBar() {
    let shape = CAShapeLayer()
    shape.path = tabBarPath()
    shape.lineWidth = 1
    shape.strokeColor = UIColor.secondarySystemFill.cgColor
    shape.fillColor = UIColor.secondarySystemFill.cgColor
    tabBar.layer.insertSublayer(shape, at: 0)
    tabBar.itemWidth = 60
    tabBar.itemPositioning = .centered
    tabBar.itemSpacing = 180
  }

  func tabBarPath() -> CGPath {
    let height: CGFloat = 37.0
    let path = UIBezierPath()
    let centerWidth = tabBar.bounds.width / 2
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: (centerWidth - height * 2), y: 0))

    path.addCurve(to: CGPoint(x: centerWidth, y: height),
                  controlPoint1: CGPoint(x: (centerWidth - 30), y: 0), controlPoint2: CGPoint(x: centerWidth - 35, y: height))

    path.addCurve(to: CGPoint(x: (centerWidth + height * 2), y: 0),
                  controlPoint1: CGPoint(x: centerWidth + 35, y: height), controlPoint2: CGPoint(x: (centerWidth + 30), y: 0))

    path.addLine(to: CGPoint(x: self.tabBar.bounds.width, y: 0))
    path.addLine(to: CGPoint(x: self.tabBar.bounds.width, y: self.tabBar.bounds.height))
    path.addLine(to: CGPoint(x: 0, y: self.tabBar.bounds.height))
    path.close()

    return path.cgPath
  }
}
