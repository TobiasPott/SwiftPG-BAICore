import SwiftUI

struct RoundedStateButton: View {
    let systemName: String;
    var size: CGFloat = Styling.buttonSize;
    let action: () -> Void;
    
    let state: Bool;
    var stateColor: Color = Styling.buttonColor;
    
    var foreground: Color = .white;
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
    
    var foreground: Color = .white;
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
    
    var foreground: Color = .white;
    var background: Color = Styling.buttonColor;
    var padding: CGFloat = Styling.buttonPadding;
    
    var body: some View {
        Button(action: action, label: {
            Image(systemName: systemName)
                .rs()
                .square(size - padding)
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
    
    var foreground: Color = .white;
    var background: Color = Styling.buttonColor;
    var padding: CGFloat = 6.0;
    
    var body: some View {
        RoundedButton(systemName: systemName, size: size, action: action, foreground: foreground, background: background, padding: padding)
    }
}
public enum PanelOrientation {
    case horizonal, vertical
}
struct RoundedPanel<Content: View>: View {
    
    
    
    @ViewBuilder let content: () -> Content;
    let orientation: PanelOrientation;
    var padding: CGFloat = 4;
    var background: Color = Styling.panelColor; 
    var paddingIsSpacing: Bool = true;
    
    var verticalAlignment: HorizontalAlignment = .center;
    var horizontalAlignment: VerticalAlignment = .center; 
    
    var body: some View {
        
        if(orientation == .vertical) {
            VStack(alignment: verticalAlignment, spacing: paddingIsSpacing ? padding : 0) { content(); }
                .padding(.all, padding)
                .background(Styling.roundedRect.foregroundColor(background))
        } else {
            HStack(alignment: horizontalAlignment, spacing: paddingIsSpacing ? padding : 0) { content(); }
                .padding(.all, padding)
                .background(Styling.roundedRect.foregroundColor(background))
        }
    }
}

struct RoundedScrollPanel<Content: View>: View {
    
    @ViewBuilder let content: () -> Content;
    let orientation: PanelOrientation    
    var scrollAxes: Axis.Set = [.vertical, .horizontal] 
    var padding: CGFloat = 4;
    var background: Color = Styling.panelColor; 
    var paddingIsSpacing: Bool = true;
    
    var verticalAlignment: HorizontalAlignment = .center;
    var horizontalAlignment: VerticalAlignment = .center; 
    
    var body: some View {
        GeometryReader(content: { geometry in
            let size = geometry.size;
            ScrollView(scrollAxes, content: {
                RoundedPanel(content: { content() }, orientation: orientation, padding: padding, background: background, paddingIsSpacing: paddingIsSpacing, verticalAlignment: verticalAlignment, horizontalAlignment: horizontalAlignment)
                    .frame(minWidth: size.width)
            })
        })
    }
}

