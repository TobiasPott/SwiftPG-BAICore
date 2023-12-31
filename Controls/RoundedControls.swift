import SwiftUI

struct RoundedLockButton: View {
    let systemName: String;
    var size: CGFloat = Styling.buttonSize;
    let action: () -> Void;
    
    let isLocked: Bool;
    
    var foreground: Color = Color.white;
    var background: Color = Styling.buttonColor;    
    var padding: CGFloat = Styling.buttonPadding;
    
    var body: some View {
        RoundedButton(systemName: systemName, size: size, action: action, foreground: foreground, background: background, padding: padding)
            .overlay(content: {
                Styling.roundedRectHalfTRBL.foregroundColor(isLocked ? Styling.red : Styling.green)
                    .frameSquare(size / 3.5)
                    .frameMax(size, Alignment.topTrailing)
            })
                
    }
}


struct RoundedStateButton: View {
    let systemName: String;
    var size: CGFloat = Styling.buttonSize;
    let action: () -> Void;
    
    let state: Bool;
    var stateColor: Color = Styling.buttonColor;
    
    var foreground: Color = Color.white;
    var background: Color = Styling.buttonColor;    
    var padding: CGFloat = Styling.buttonPadding;
    
    var body: some View {
        RoundedButton(systemName: systemName, size: size, action: action,  foreground: foreground, background: state ? stateColor: background, padding: padding)
    }
}

struct RoundedButtonMedium: View {
    public static let defaultSize: CGFloat = Styling.medButtonSize;
    
    let systemName: String;
    var size: CGFloat = defaultSize;
    let action: () -> Void;
    
    var foreground: Color = Color.white;
    var background: Color = Styling.buttonColor;
    var padding: CGFloat = Styling.medButtonPadding;
    
    
    var body: some View {
        RoundedButton(systemName: systemName, size: size, action: action, foreground: foreground, background: background, padding: padding)
    }
}
struct RoundedButton: View {
    public static let defaultSize: CGFloat = Styling.buttonSize;
    
    let systemName: String;
    var size: CGFloat = defaultSize;
    let action: () -> Void;
    
    var foreground: Color = Color.white;
    var background: Color = Styling.buttonColor;
    var padding: CGFloat = Styling.buttonPadding;
    
    var body: some View {
        Button(action: action, label: {
            Image(systemName: systemName)
                .rs()
                .frameSquare(size - padding)
                .foregroundColor(foreground)
                .padding(padding)
        })
        .frame(width: size, height: size)
        .background(Styling.roundedRect.foregroundColor(background))
    }
}

struct RoundedButtonMini: View {
    public static let defaultSize: CGFloat = 28.0;
    
    let systemName: String;
    var size: CGFloat = defaultSize;
    let action: () -> Void;
    
    var foreground: Color = Color.white;
    var background: Color = Styling.buttonColor;
    var padding: CGFloat = 6.0;
    
    var body: some View {
        RoundedButton(systemName: systemName, size: size, action: action, foreground: foreground, background: background, padding: padding)
    }
}
