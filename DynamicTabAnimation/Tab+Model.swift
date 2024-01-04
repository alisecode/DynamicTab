//
//  Tab+Model.swift
//  DynamicTabAnimation
//
//  Created by Alisa Serhiienko on 02.01.2024.
//

import SwiftUI

struct Tab: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var minX: CGFloat = 0
    var width: CGFloat = 0
    
    static var preview: [Self] {
        [
            .init(title: "Tokyo"),
            .init(title: "Oslo"),
            .init(title: "London"),
            .init(title: "Rome")
        ]
    }
}
