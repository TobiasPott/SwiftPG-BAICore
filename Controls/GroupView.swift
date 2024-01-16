import SwiftUI

enum GroupViewStyles {
    case colorScheme, blueprint
}

struct GroupView<LabelType: View, Content: View>: View {
    
    
    @ViewBuilder let label: LabelType;    
    @ViewBuilder let content: () -> Content;
    var style: GroupViewStyles = GroupViewStyles.colorScheme
    
    var body: some View {
        let result = VStack(alignment: HorizontalAlignment.leading) {
            HStack() {
                label
                    .font(Styling.headlineFont)
            }    
            .frame(alignment: Alignment.topLeading)
            content()
        }
            .padding()
            .mask(Styling.roundedRect)
        
        if (style == .colorScheme) {
            return AnyView(result.modifier(DefaultGroupViewStyle())) 
        } else {
            return AnyView(result.modifier(BlueprintGroupViewStyle()))
        }
        
    }
    
}

//
//protocol GroupViewStyle {
//    associatedtype Body: View
//    typealias Configuration = GroupViewStyleConfiguration
//    
//    func makeBody(configuration: Self.Configuration) -> Self.Body
//}
//struct GroupViewStyleConfiguration {
//    /// A type-erased label of a Card.
//    struct Label: View {
//        init<Content: View>(content: Content) {
//            body = AnyView(content)
//        }
//        var body: AnyView
//    }
//    struct Content: View {
//        init<Content: View>(content: Content) {
//            body = AnyView(content)
//        }
//        var body: AnyView
//    }
//    
//    let label: GroupViewStyleConfiguration.Label
//    let content: GroupViewStyleConfiguration.Content
//}
//
//struct RoundedRectangleCardStyle: GroupViewStyle {
//    func makeBody(configuration: Configuration) -> some View {
//        VStack(alignment: HorizontalAlignment.leading) {
//            HStack() {
//                configuration.label
//                    .font(Styling.headlineFont)
//            }    
//            .frame(alignment: Alignment.topLeading)
//            configuration.content
//        }
//        
//    }
//}
struct DefaultGroupViewStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color(uiColor: UIColor.secondarySystemGroupedBackground))      
            .mask(Styling.roundedRect)  
    }
}
struct BlueprintGroupViewStyle: ViewModifier {
    static var gridBackground: some View { 
        ZStack(alignment: Alignment.center) {
            Styling.blueprintColor
            Grid(64.0, gridColor: BlueprintGrid.lineColor, lineWidth: 1.0)
            Grid(32.0 / 4.0, gridColor: BlueprintGrid.lineColor, lineWidth: 1.0)
        }
    }
    
    func body(content: Content) -> some View {
        content
            .background(content: {
                BlueprintGroupViewStyle.gridBackground.aspectRatio(1.0, contentMode: ContentMode.fill)
            })        
            .mask(Styling.roundedRect)
        
    }
}
