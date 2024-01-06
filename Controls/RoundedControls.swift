import SwiftUI


struct RoundedLockButton: View {
    let systemName: String;
    var size: CGFloat = Styling.buttonSize;
    let action: () -> Void;
    
    let isLocked: Bool;
    
    var foreground: Color = Styling.white;
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
    
    var foreground: Color = Styling.white;
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
    
    var foreground: Color = Styling.white;
    var background: Color = Styling.buttonColor;
    var padding: CGFloat = Styling.medButtonPadding;
    
    
    var body: some View {
        RoundedButton(systemName: systemName, size: size, action: action, foreground: foreground, background: background, padding: padding)
    }
}
struct RoundedImage: View {
    public static let defaultSize: CGFloat = Styling.buttonSize;
    
    let systemName: String;
    var size: CGFloat = defaultSize;
    
    var foreground: Color = Styling.white;
    var background: Color = Styling.buttonColor;
    var padding: CGFloat = Styling.buttonPadding;
    
    var body: some View {
        Image(systemName: systemName)
            .rs()
            .frameSquare(size - padding)
            .foregroundColor(foreground)
            .padding(padding)
            .frame(width: size, height: size)
            .background(background)
            .mask(Styling.roundedRect)
    }
}
struct RoundedButton: View {
    public static let defaultSize: CGFloat = Styling.buttonSize;
    
    let systemName: String;
    var size: CGFloat = defaultSize;
    let action: () -> Void;
    
    var foreground: Color = Styling.white;
    var background: Color = Styling.buttonColor;
    var padding: CGFloat = Styling.buttonPadding;
    
    var body: some View {
        RoundedImage(systemName: systemName, size: size, foreground: foreground, background: background, padding: padding)
            .onTapGesture(perform: action)
    }
}

struct RoundedButtonMini: View {
    public static let defaultSize: CGFloat = 28.0;
    
    let systemName: String;
    var size: CGFloat = defaultSize;
    let action: () -> Void;
    
    var foreground: Color = Styling.white;
    var background: Color = Styling.buttonColor;
    var padding: CGFloat = 6.0;
    
    var body: some View {
        RoundedButton(systemName: systemName, size: size, action: action, foreground: foreground, background: background, padding: padding)
    }
}
