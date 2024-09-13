//
//  BouncyButtonStyle.swift
//  Rides
//
//  Created by Matthias Mellouli on 2024-09-12.
//

import SwiftUI

struct BouncyButtonStyle: ButtonStyle {
    
    private let appliedScale: Double = 0.92
    
    func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed
        
        let scaleEffect = isPressed ? appliedScale : 1.0
        let shadowOpacity = isPressed ? 0.18 : 0.1
        let shadowRadius = isPressed ? 3.0 : 5.0
        let opacity = isPressed ? 0.85 : 1.0
        
        configuration.label
            .scaleEffect(scaleEffect)
            .shadow(color: .black.opacity(shadowOpacity), radius: shadowRadius, x: 0, y: 1)
            .animation(.easeInOut(duration: 0.1), value: isPressed)
            .opacity(opacity)
    }
}
