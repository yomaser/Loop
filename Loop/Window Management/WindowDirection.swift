//
//  WindowDirection.swift
//  Loop
//
//  Created by Kai Azim on 2023-06-14.
//

import SwiftUI
import Defaults

// Enum that stores all possible resizing options
// swiftlint:disable:next type_body_length
enum WindowDirection: CaseIterable, Identifiable {
    var id: Self { return self }

    // General
    case noAction
    case maximize
    case fullscreen
    case lastDirection
    case center
    case initialFrame
    case hide

    // To cycle through directions
    case cycleTop
    case cycleBottom
    case cycleRight
    case cycleLeft

    // Halves
    case topHalf
    case rightHalf
    case bottomHalf
    case leftHalf

    // Quarters
    case topLeftQuarter
    case topRightQuarter
    case bottomRightQuarter
    case bottomLeftQuarter

    // Horizontal Thirds
    case rightThird
    case rightTwoThirds
    case horizontalCenterThird
    case leftThird
    case leftTwoThirds

    // Vertical Thirds
    case topThird
    case topTwoThirds
    case verticalCenterThird
    case bottomThird
    case bottomTwoThirds

    // These are used in the menubar resize submenu
    static var general: [WindowDirection] {
        [.initialFrame, .lastDirection, .center, .maximize, .fullscreen]
    }
    static var halves: [WindowDirection] {
        [.topHalf, .bottomHalf, .leftHalf, .rightHalf]
    }
    static var quarters: [WindowDirection] {
        [.topLeftQuarter, .topRightQuarter, .bottomLeftQuarter, .bottomRightQuarter]
    }
    static var horizontalThirds: [WindowDirection] {
        [.rightThird, .rightTwoThirds, .horizontalCenterThird, .leftTwoThirds, .leftThird]
    }
    static var verticalThirds: [WindowDirection] {
        [.topThird, .topTwoThirds, .verticalCenterThird, .bottomTwoThirds, .bottomThird]
    }
    static var cyclable: [WindowDirection] {
        [.cycleTop, .cycleBottom, .cycleLeft, .cycleRight]
    }

    var cyclable: Bool {
        WindowDirection.cyclable.contains(self)
    }

    // Used in the settings window to loop over the possible combinations
    var nextPreviewDirection: WindowDirection {
        switch self {
        case .noAction:             .cycleTop
        case .cycleTop:             .topRightQuarter
        case .topRightQuarter:      .cycleRight
        case .cycleRight:           .bottomRightQuarter
        case .bottomRightQuarter:   .cycleBottom
        case .cycleBottom:          .bottomLeftQuarter
        case .bottomLeftQuarter:    .cycleLeft
        case .cycleLeft:            .topLeftQuarter
        case .topLeftQuarter:       .maximize
        case .maximize:             .noAction
        default:                    .noAction
        }
    }

    var radialMenuAngle: Double? {
        switch self {
        case .topHalf:              0
        case .topRightQuarter:      45
        case .rightHalf:            90
        case .bottomRightQuarter:   135
        case .bottomHalf:           180
        case .bottomLeftQuarter:    225
        case .leftHalf:             270
        case .topLeftQuarter:       315
        case .maximize:             0
        default:                    nil
        }
    }

    var name: String? {
        switch self {
        case .noAction:                 nil
        case .maximize:                 "Maximize"
        case .fullscreen:               "Fullscreen"
        case .lastDirection:            "Last Direction"
        case .center:                   "Center"
        case .initialFrame:             "Initial Frame"
        case .hide:                     "Hide"

        case .cycleTop:                 "Cycle Top"
        case .cycleBottom:              "Cycle Bottom"
        case .cycleRight:               "Cycle Right"
        case .cycleLeft:                "Cycle Left"

        case .topHalf:                  "Top Half"
        case .rightHalf:                "Right Half"
        case .bottomHalf:               "Bottom Half"
        case .leftHalf:                 "Left Half"

        case .topLeftQuarter:           "Top Left Quarter"
        case .topRightQuarter:          "Top Right Quarter"
        case .bottomRightQuarter:       "Bottom Right Quarter"
        case .bottomLeftQuarter:        "Bottom Left Quarter"

        case .leftThird:                "Left Third"
        case .leftTwoThirds:            "Left Two Thirds"
        case .horizontalCenterThird:    "Horizontal Center Third"
        case .rightTwoThirds:           "Right Two Thirds"
        case .rightThird:               "Right Third"

        case .topThird:                 "Top Third"
        case .topTwoThirds:             "Top Two Thirds"
        case .verticalCenterThird:      "Vertical Center Third"
        case .bottomThird:              "Bottom Third"
        case .bottomTwoThirds:          "Bottom Two Thirds"
        }
    }

    var keybind: [Set<CGKeyCode>] {
        switch self {
        case .maximize:                 Defaults[.maximizeKeybind]
        case .fullscreen:               Defaults[.fullscreenKeybind]
        case .lastDirection:            Defaults[.lastDirectionKeybind]
        case .center:                   Defaults[.centerKeybind]
        case .initialFrame:             Defaults[.initialFrameKeybind]
        case .hide:                     Defaults[.hideKeybind]

        case .cycleTop:                 Defaults[.cycleTopKeybind]
        case .cycleRight:               Defaults[.cycleRightKeybind]
        case .cycleBottom:              Defaults[.cycleBottomKeybind]
        case .cycleLeft:                Defaults[.cycleLeftKeybind]

        case .topLeftQuarter:           Defaults[.topLeftQuarter]
        case .topRightQuarter:          Defaults[.topRightQuarter]
        case .bottomRightQuarter:       Defaults[.bottomRightQuarter]
        case .bottomLeftQuarter:        Defaults[.bottomLeftQuarter]

        case .leftThird:                Defaults[.leftThird]
        case .leftTwoThirds:            Defaults[.leftTwoThirds]
        case .horizontalCenterThird:    Defaults[.horizontalCenterThird]
        case .rightTwoThirds:           Defaults[.rightTwoThirds]
        case .rightThird:               Defaults[.rightThird]

        default:                        [[]]
        }
    }

    var menuBarImage: Image? {
        switch self {
        case .maximize:                 Image(systemName: "rectangle.inset.filled")
        case .fullscreen:               Image(systemName: "rectangle.fill")
        case .center:                   Image(systemName: "rectangle.center.inset.filled")
        case .lastDirection:            Image("custom.backward.fill.rectangle.fill")
        case .initialFrame:             Image("custom.backward.end.alt.fill.rectangle.fill")

        case .topHalf:                  Image(systemName: "rectangle.tophalf.inset.filled")
        case .rightHalf:                Image(systemName: "rectangle.righthalf.inset.filled")
        case .bottomHalf:               Image(systemName: "rectangle.bottomhalf.inset.filled")
        case .leftHalf:                 Image(systemName: "rectangle.lefthalf.inset.filled")

        case .topLeftQuarter:           Image(systemName: "rectangle.inset.topleft.filled")
        case .topRightQuarter:          Image(systemName: "rectangle.inset.topright.filled")
        case .bottomRightQuarter:       Image(systemName: "rectangle.inset.bottomright.filled")
        case .bottomLeftQuarter:        Image(systemName: "rectangle.inset.bottomleft.filled")

        case .rightThird:               Image(systemName: "rectangle.rightthird.inset.filled")
        case .rightTwoThirds:           Image("custom.rectangle.righttwothirds.inset.filled")
        case .horizontalCenterThird:    Image("custom.rectangle.horizontalcenterthird.inset.filled")
        case .leftThird:                Image(systemName: "rectangle.leftthird.inset.filled")
        case .leftTwoThirds:            Image("custom.rectangle.lefttwothirds.inset.filled")

        case .topThird:                 Image(systemName: "rectangle.topthird.inset.filled")
        case .topTwoThirds:             Image("custom.rectangle.toptwothirds.inset.filled")
        case .verticalCenterThird:      Image("custom.rectangle.verticalcenterthird.inset.filled")
        case .bottomThird:              Image(systemName: "rectangle.bottomthird.inset.filled")
        case .bottomTwoThirds:          Image("custom.rectangle.bottomtwothirds.inset.filled")
        default:                        nil
        }
    }

    var radialMenuImage: Image? {
        switch self {
        case .hide:                     Image("custom.rectangle.inset.filled.slash")
        default:                        nil
        }
    }

    var edgesTouchingScreen: [Edge] {
        switch self {
        case .maximize:                 [.top, .bottom, .leading, .trailing]
        case .topHalf:                  [.top, .leading, .trailing]
        case .rightHalf:                [.top, .bottom, .trailing]
        case .bottomHalf:               [.bottom, .leading, .trailing]
        case .leftHalf:                 [.top, .bottom, .leading]
        case .topLeftQuarter:           [.top, .leading]
        case .topRightQuarter:          [.top, .trailing]
        case .bottomRightQuarter:       [.bottom, .trailing]
        case .bottomLeftQuarter:        [.bottom, .leading]
        case .rightThird:               [.top, .bottom, .trailing]
        case .rightTwoThirds:           [.top, .bottom, .trailing]
        case .horizontalCenterThird:    [.top, .bottom]
        case .leftThird:                [.top, .bottom, .leading]
        case .leftTwoThirds:            [.top, .bottom, .leading]
        case .topThird:                 [.top, .leading, .trailing]
        case .topTwoThirds:             [.top, .leading, .trailing]
        case .verticalCenterThird:      [.leading, .trailing]
        case .bottomThird:              [.bottom, .leading, .trailing]
        case .bottomTwoThirds:          [.bottom, .leading, .trailing]
        default:                        []
        }
    }

    static func processSnap(
        mouseLocation: CGPoint,
        currentDirection: WindowDirection,
        screenFrame: CGRect,
        ignoredFrame: CGRect
    ) -> WindowDirection {
        var newDirection: WindowDirection = .noAction

        if mouseLocation.x < ignoredFrame.minX {
            newDirection = WindowDirection.processLeftSnap(mouseLocation.y, screenFrame.maxY, currentDirection)
        } else if mouseLocation.x > ignoredFrame.maxX {
            newDirection = WindowDirection.processRightSnap(mouseLocation.y, screenFrame.maxY, currentDirection)
        } else if mouseLocation.y < ignoredFrame.minY {
            newDirection = WindowDirection.processTopSnap(mouseLocation.x, screenFrame.maxX, currentDirection)
        } else if mouseLocation.y > ignoredFrame.maxY {
            newDirection = WindowDirection.processBottomSnap(mouseLocation.x, screenFrame.maxX, currentDirection)
        }

        return newDirection
    }

    static func processLeftSnap(
        _ mouseY: CGFloat,
        _ maxY: CGFloat,
        _ currentDirection: WindowDirection
    ) -> WindowDirection {
        if mouseY < maxY * 1/8 {
            return .topLeftQuarter
        } else if mouseY > maxY * 7/8 {
            return .bottomLeftQuarter
        } else {
            return .leftHalf
        }
    }

    static func processRightSnap(
        _ mouseY: CGFloat,
        _ maxY: CGFloat,
        _ currentDirection: WindowDirection
    ) -> WindowDirection {
        if mouseY < maxY * 1/8 {
            return .topRightQuarter
        } else if mouseY > maxY * 7/8 {
            return .bottomRightQuarter
        } else {
            return .rightHalf
        }
    }

    static func processTopSnap(
        _ mouseX: CGFloat,
        _ maxX: CGFloat,
        _ currentDirection: WindowDirection
    ) -> WindowDirection {
        var newDirection: WindowDirection = .noAction

        if mouseX < maxX * 1/5 {
            newDirection = .topHalf
        } else if mouseX < maxX * 4/5 {
            newDirection = .maximize
        } else if mouseX < maxX {
            newDirection = .topHalf
        }

        return newDirection
    }

    static func processBottomSnap(
        _ mouseX: CGFloat,
        _ maxX: CGFloat,
        _ currentDirection: WindowDirection
    ) -> WindowDirection {
        var newDirection: WindowDirection = .noAction

        if mouseX < maxX * 1/3 {
            newDirection = .leftThird
        } else if mouseX < maxX * 2/3 {
            if currentDirection == .leftThird || currentDirection == .leftTwoThirds {
                newDirection = .leftTwoThirds
            } else if currentDirection == .rightThird || currentDirection == .rightTwoThirds {
                newDirection = .rightTwoThirds
            } else {
                newDirection = .bottomHalf
            }
        } else if mouseX < maxX {
            newDirection = .rightThird
        }

        return newDirection
    }

    var frameMultiplyValues: CGRect? {
        switch self {
        case .maximize:                 CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        case .fullscreen:               CGRect(x: 0, y: 0, width: 1.0, height: 1.0)

        // Halves
        case .topHalf:                  CGRect(x: 0, y: 0, width: 1.0, height: 1.0/2.0)
        case .rightHalf:                CGRect(x: 1.0/2.0, y: 0, width: 1.0/2.0, height: 1.0)
        case .bottomHalf:               CGRect(x: 0, y: 1.0/2.0, width: 1.0, height: 1.0/2.0)
        case .leftHalf:                 CGRect(x: 0, y: 0, width: 1.0/2.0, height: 1.0)

        // Quarters
        case .topLeftQuarter:           CGRect(x: 0, y: 0, width: 1.0/2.0, height: 1.0/2.0)
        case .topRightQuarter:          CGRect(x: 1.0/2.0, y: 0, width: 1.0/2.0, height: 1.0/2.0)
        case .bottomRightQuarter:       CGRect(x: 1.0/2.0, y: 1.0/2.0, width: 1.0/2.0, height: 1.0/2.0)
        case .bottomLeftQuarter:        CGRect(x: 0, y: 1.0/2.0, width: 1.0/2.0, height: 1.0/2.0)

        // Thirds (Horizontal)
        case .rightThird:               CGRect(x: 2.0/3.0, y: 0, width: 1.0/3.0, height: 1.0)
        case .rightTwoThirds:           CGRect(x: 1.0/3.0, y: 0, width: 2.0/3.0, height: 1.0)
        case .horizontalCenterThird:    CGRect(x: 1.0/3.0, y: 0, width: 1.0/3.0, height: 1.0)
        case .leftThird:                CGRect(x: 0, y: 0, width: 1.0/3.0, height: 1.0)
        case .leftTwoThirds:            CGRect(x: 0, y: 0, width: 2.0/3.0, height: 1.0)

        // Thirds (Vertical)
        case .topThird:                 CGRect(x: 0, y: 0, width: 1.0, height: 1.0/3.0)
        case .topTwoThirds:             CGRect(x: 0, y: 0, width: 1.0, height: 2.0/3.0)
        case .verticalCenterThird:      CGRect(x: 0, y: 1.0/3.0, width: 1.0, height: 1.0/3.0)
        case .bottomThird:              CGRect(x: 0, y: 2.0/3.0, width: 1.0, height: 1.0/3.0)
        case .bottomTwoThirds:          CGRect(x: 0, y: 1.0/3.0, width: 1.0, height: 2.0/3.0)
        default:                        nil
        }
    }

    func nextCyclingDirection(from: WindowDirection) -> WindowDirection {
        switch self {
        case .cycleTop:
            switch from {
            case .topHalf:              return .topThird
            case .topThird:             return .topTwoThirds
            default:                    return .topHalf
            }
        case .cycleBottom:
            switch from {
            case .bottomHalf:           return .bottomThird
            case .bottomThird:          return .bottomTwoThirds
            default:                    return .bottomHalf
            }
        case .cycleLeft:
            switch from {
            case .leftHalf:             return .leftThird
            case .leftThird:            return .leftTwoThirds
            default:                    return .leftHalf
            }
        case .cycleRight:
            switch from {
            case .rightHalf:            return .rightThird
            case .rightThird:           return .rightTwoThirds
            default:                    return .rightHalf
            }
        default: return .noAction
        }
    }
}
