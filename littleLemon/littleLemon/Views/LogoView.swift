//
//  LogoView.swift
//  littleLemon
//
//  Created by Karmen Mirzoyan on 4/16/26.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        VStack(alignment: .center) {
            Image("littleLemon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 40)
        }
    }
}

#Preview {
    LogoView()
}
