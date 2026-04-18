import Foundation
import SwiftUI

struct NavbarTitleShowPreferenceKey: PreferenceKey {
    
    static var defaultValue: Bool = true
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

struct NavbarRightViewShowPreferenceKey: PreferenceKey {
    
    static var defaultValue: Bool = true
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

struct NavbarBackButtonHiddenPreferenceKey: PreferenceKey {
    
    static var defaultValue: Bool = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}


extension View {
    
    func navbarTitleShow(_ show: Bool) -> some View {
        preference(key: NavbarTitleShowPreferenceKey.self, value: show)
    }
    
    func navbarBackBattonHidden(_ hidden: Bool) -> some View {
        preference(key: NavbarBackButtonHiddenPreferenceKey.self, value: hidden)
    }
    
    func navbarRightViewShow(_ show: Bool) -> some View {
        preference(key: NavbarRightViewShowPreferenceKey.self, value: show)
    }
    
    func navbarItems(titleShow: Bool = true, rightViewShow: Bool = false, backButtonHidden: Bool = true) -> some View {
        self
            .navbarTitleShow(titleShow)
            .navbarRightViewShow(rightViewShow)
            .navbarBackBattonHidden(backButtonHidden)
    }
    
    func hideNavbar() -> some View {
        navbarItems(titleShow: false, rightViewShow: false, backButtonHidden: true)
    }
}
