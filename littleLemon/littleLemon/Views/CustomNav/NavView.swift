//
//  NavView.swift
//  littleLemon
//
//  Created by Karmen Mirzoyan on 4/16/26.
//

import SwiftUI

struct NavView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        NavigationStack {
            NavbarContainer {
                content
            }
            .toolbarVisibility(.hidden, for: .navigationBar)
        }
        
    }
}

#Preview {
    NavView {
        Color.orange.ignoresSafeArea()
    }
}
