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
            content()
        }
            .frame(alignment: Alignment.topLeading)
            .padding()
            .mask(Styling.roundedRect)
        
        if (style == .colorScheme) {
            return AnyView(result.modifier(DefaultGroupViewStyle())) 
        } else {
            return AnyView(result.modifier(BlueprintGroupViewStyle()))
        }
        
    }
    
}
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
