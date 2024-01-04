//
//  Utils.swift
//  DynamicTabAnimation
//
//  Created by Alisa Serhiienko on 02.01.2024.
//

import SwiftUI

struct Utils {
    private var length: Int
    private var outputRange: [CGFloat]
    private var inputRange: [CGFloat]
    
    init(outputRange: [CGFloat], inputRange: [CGFloat]) {
        assert(inputRange.count == outputRange.count)
        self.length = inputRange.count - 1
        self.outputRange = outputRange
        self.inputRange = inputRange
    }
    
    func calculate(for x: CGFloat) -> CGFloat {
        if x <= inputRange[0] { return outputRange[0] }
        for index in 1...length {
            let x1 = inputRange[index - 1]
            let x2 = inputRange[index]
            
            let y1 = outputRange[index - 1]
            let y2 = outputRange[index]
            
            if x <= inputRange[index] {
                let y = y1 + ((y2 - y1) / (x2 - x1) * (x - x1))
                return y
            }

        }
        
        return outputRange[length]
    }
}
