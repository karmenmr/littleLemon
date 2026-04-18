import SwiftUI

struct FieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(style: StrokeStyle(lineWidth: 1))
                    .fill(Color.black)
            )
            .foregroundStyle(Color.black)
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            .keyboardType(.default)
            .lineLimit(1)
    }
}

struct ButtonModifierPrimary: ViewModifier {
    let color: Color
    let textColor: Color
    init(_ color: Color = Color.primGreen, textColor: Color = Color.lightAccent) { self.color = color; self.textColor = textColor; }
    func body(content: Content) -> some View {
        content
            .font(.custom("Karla-Regular_Medium", size: 19))
            .foregroundColor(textColor)
            .padding()
            .frame(height: 50)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(color)
            }
    }
}

struct ButtonModifierSecondary: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Karla-Regular_Medium", size: 19))
            .foregroundColor(Color.darkAccent)
            .padding()
            .frame(height: 50)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1)
                    .fill(Color.darkAccent)
            }
    }
}

struct TextLabelModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Karla-Regular_Medium", size: 18))
            .foregroundStyle(Color.gray)
    }
}
