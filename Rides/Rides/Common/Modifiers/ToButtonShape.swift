//
//  ToButtonShape.swift
//  Rides
//
//  Created by Matthias Mellouli on 2024-09-12.
//

import SwiftUI

struct ToButtonShape: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            .background(.appOrange)
            .clipShape(Capsule())
            .foregroundColor(.white)
    }
}

extension View {
    func toButtonShape() -> some View {
        modifier(ToButtonShape())
    }
}
