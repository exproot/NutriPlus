//
//  MainTabBarShapeLayer.swift
//  NutriPlus
//
//  Created by Ertan Yağmur on 8.01.2025.
//

import UIKit

extension MainTabBarController {
  func setupTabBar() {
    tabBar.layer.sublayers?
      .filter { $0 is CAShapeLayer }
      .forEach { $0.removeFromSuperlayer() }

    let shape = CAShapeLayer()
    shape.path = tabBarPath()
    shape.lineWidth = 1.0
    shape.strokeColor = UIColor.separator.cgColor
    shape.fillColor = UIColor.clear.cgColor

    tabBar.layer.insertSublayer(shape, at: 0)
    tabBar.itemWidth = 60.0
    tabBar.itemPositioning = .centered
    tabBar.itemSpacing = 180.0
  }

  func tabBarPath() -> CGPath {
    let height: CGFloat = 37.0
    let path = UIBezierPath()
    let centerWidth = tabBar.bounds.width / 2

    path.move(to: CGPoint(x: 0, y: 0)) // begin at top left
    path.addLine(to: CGPoint(x: (centerWidth - height * 2), y: 0)) // point before the first curve

    //First curve dippin down
    path.addCurve(to: CGPoint(x: centerWidth, y: height),
                  controlPoint1: CGPoint(x: (centerWidth - 30), y: 0),
                  controlPoint2: CGPoint(x: centerWidth - 35, y: height))

    //Second curve to raise up
    path.addCurve(to: CGPoint(x: (centerWidth + height * 2), y: 0),
                  controlPoint1: CGPoint(x: centerWidth + 35, y: height),
                  controlPoint2: CGPoint(x: (centerWidth + 30), y: 0))

    // stop at right corner
    path.addLine(to: CGPoint(x: self.tabBar.bounds.width, y: 0))

    return path.cgPath
  }
}
