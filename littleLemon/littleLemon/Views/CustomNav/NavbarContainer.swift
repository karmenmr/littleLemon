//
//  NavbarContainer.swift
//  littleLemon
//
//  Created by Karmen Mirzoyan on 4/16/26.
//

import SwiftUI

struct NavbarContainer<Content: View>: View {
    @State private var hideBackButton = true
    @State private var showTitleView = false
    @State private var showRightView = false
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Navbar(hideBackButton: hideBackButton, showTitleView: showTitleView, showRightView: showRightView)
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onPreferenceChange(NavbarTitleShowPreferenceKey.self) { value in
            self.showTitleView = value
        }
        .onPreferenceChange(NavbarRightViewShowPreferenceKey.self) { value in
            self.showRightView = value
        }
        .onPreferenceChange(NavbarBackButtonHiddenPreferenceKey.self) { value in
            self.hideBackButton = value
        }
    }
}

#Preview {
    NavbarContainer {
        ZStack {
            Color.green.ignoresSafeArea()
            Text("Hello, World!")
        }
        .navbarBackBattonHidden(true)
        .navbarRightViewShow(false)
        
    }
}
