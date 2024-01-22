import SwiftUI

struct RoundedLockButton: View {
    let sName: String;
    var size: CGFloat = Styling.buttonSize;
    let action: () -> Void;
    
    let isLocked: Bool;
    
    var foreground: Color = Styling.white;
    var background: Color = Styling.buttonColor;    
    var padding: CGFloat = Styling.buttonPadding;
    
    var body: some View {
        RoundedButton(sName: sName, size: size, action: action, foreground: foreground, background: background, padding: padding)
            .overlay(content: {
                Styling.roundedRectHalfTRBL.foregroundColor(isLocked ? Styling.red : Styling.green)
                    .frameSquare(size / 3.5)
                    .frameMax(size, Alignment.topTrailing)
            })
        
    }
}
struct RoundedBadgeButton: View {
    let sName: String;
    var size: CGFloat = Styling.buttonSize;
    let badgeSName: String;
    let action: () -> Void;
    
    var foreground: Color = Styling.white;
    var background: Color = Styling.buttonColor;    
    var padding: CGFloat = Styling.buttonPadding;
    
    var body: some View {
        RoundedButton(sName: sName, size: size, action: action, foreground: foreground, background: background, padding: padding)
            .overlay(content: {
                SNImage.get(badgeSName)
                    .frameSquare(size / 3.5)
                    .frameMax(size, Alignment.topTrailing)
            })
        
    }
}


struct RoundedStateButton: View {
    let sName: String;
    var size: CGFloat = Styling.buttonSize;
    let action: () -> Void;
    
    let state: Bool;
    var stateColor: Color = Styling.buttonColor;
    
    var foreground: Color = Styling.white;
    var background: Color = Styling.buttonColor;    
    var padding: CGFloat = Styling.buttonPadding;
    
    var body: some View {
        RoundedButton(sName: sName, size: size, action: action,  foreground: foreground, background: state ? stateColor: background, padding: padding)
    }
}

struct RoundedViewStyle: ViewModifier {
    var size: CGFloat = Styling.buttonSize;
    
    var foreground: Color = Styling.white;
    var background: Color = Styling.clear;
    var padding: CGFloat = Styling.buttonPadding;
    
    func body(content: Content) -> some View {
        content
            .frameSquare(size - padding)
            .padding(padding)
            .frame(width: size, height: size)
            .foregroundColor(foreground)
            .background(background)
            .mask(Styling.roundedRect)
    }
}

struct RoundedImage: View {
    public static let defaultSize: CGFloat = Styling.buttonSize;
    
    let sName: String;
    var size: CGFloat = defaultSize;
    
    var foreground: Color = Styling.white;
    var background: Color = Styling.buttonColor;
    var padding: CGFloat = Styling.buttonPadding;
    
    var body: some View {
        Image(systemName: sName)
            .rs()
            .modifier(RoundedViewStyle(size: size, foreground: foreground, background: background, padding: padding))
    }
}
struct RoundedBadgeImage: View {
    public static let defaultSize: CGFloat = Styling.buttonSize;
    
    let sName: String;
    var size: CGFloat = defaultSize;
    let badgeSName: String;
    
    var foreground: Color = Styling.white;
    var background: Color = Styling.buttonColor;
    var padding: CGFloat = Styling.buttonPadding
    
    var body: some View {
        Image(systemName: sName)
            .rs()
            .modifier(RoundedViewStyle(size: size, foreground: foreground, background: background, padding: padding))
            .overlay(content: {
                SNImage.get(badgeSName).resizable()
                    .frameSquare(size / 3.0)
                    .frameMax(size, Alignment.topTrailing)
            })
            .mask(Styling.roundedRect)
    }
}
struct RoundedButton: View {
    public static let defaultSize: CGFloat = Styling.buttonSize;
    
    let sName: String;
    var leadingLabel: String? = nil
    var trailingLabel: String? = nil
    var size: CGFloat = defaultSize;
    let action: () -> Void;
    
    var foreground: Color = Styling.white;
    var background: Color = Styling.buttonColor;
    var padding: CGFloat = Styling.buttonPadding;
    
    var body: some View {
        HStack {
            if (leadingLabel != nil) { Text(leadingLabel!) }
            RoundedImage(sName: sName, size: size, foreground: foreground, background: background, padding: padding)
            if (trailingLabel != nil) { Text(trailingLabel!) }
        }
            .onTapGesture(perform: { withAnimation { action() } })
    }
}
