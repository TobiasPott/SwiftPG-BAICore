import SwiftUI

struct VerticalSlider<V: BinaryFloatingPoint>: View {
    var value: Binding<V>
    var range: ClosedRange<V> = 0...1
    var step: V.Stride? = nil
    var onEditingChanged: (Bool) -> Void = { _ in }
    
    private let drawRadius: CGFloat = 11.0
    private let dragRadius: CGFloat = 25.0
    private let lineWidth: CGFloat = 3.0
    
    @State private var validDrag = false
    
    init(value: Binding<V>, in range: ClosedRange<V> = 0...1, step: V.Stride? = nil, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.value = value
        
        if let step = step {
            self.step = step
            var newUpperbound = range.lowerBound
            while newUpperbound.advanced(by: step) <= range.upperBound{
                newUpperbound = newUpperbound.advanced(by: step)
            }
            self.range = range.lowerBound...newUpperbound
        } else {
            self.range = range
        }
        self.onEditingChanged = onEditingChanged
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(spacing: 0.0) {
                    // Gray section of line
                    Rectangle()
                        .foregroundColor(Color(UIColor.systemGray4))
                        .frame(height: self.getPoint(in: geometry).y)
                        .clipShape(RoundedRectangle(cornerRadius: 2.0))
                    
                    // Blue section of line
                    Rectangle()
                        .foregroundColor(Color(UIColor.systemBlue))
                        .frame(height: geometry.size.height - self.getPoint(in: geometry).y)
                        .clipShape(RoundedRectangle(cornerRadius: 3.0))
                }
                .frame(width: self.lineWidth)
                
                // Handle
//                RoundedRectangle(cornerSize: Styling.roundedCornerSize)
                Circle()
                    .frame(width: 2.0 * self.drawRadius, height: 2.0 * self.drawRadius)
                    .position(self.getPoint(in: geometry))
                    .foregroundColor(Styling.white)
                    .shadow(radius: 2.0, y: 2.0)
                
                // Catches drag gesture
                Rectangle()
                    .frame(minWidth: CGFloat(self.dragRadius))
                    .foregroundColor(Styling.red.opacity(0.001))
                    .gesture(
                        DragGesture(minimumDistance: 0.0)
                            .onEnded({ _ in
                                self.validDrag = false
                                self.onEditingChanged(false)
                            })
                            .onChanged(self.handleDragged(in: geometry))
                    )
            }
        }
    }
}

extension VerticalSlider {
    private func getPoint(in geometry: GeometryProxy) -> CGPoint {
        let x = geometry.size.width / 2.0
        let location = value.wrappedValue - range.lowerBound
        let scale = V(2.0 * drawRadius - geometry.size.height) / (range.upperBound - range.lowerBound)
        let y = CGFloat(location * scale) + geometry.size.height - drawRadius
        return CGPoint(x: x, y: y)
    }
    
    private func handleDragged(in geometry: GeometryProxy) -> (DragGesture.Value) -> Void {
        return { drag in
            if drag.startLocation.distance(to: self.getPoint(in: geometry)) < self.dragRadius && !self.validDrag {
                self.validDrag = true
                self.onEditingChanged(true)
            }
            
            if self.validDrag {
                let location = drag.location.y - geometry.size.height + self.drawRadius
                let scale = CGFloat(self.range.upperBound - self.range.lowerBound) / (2.0 * self.drawRadius - geometry.size.height)
                let newValue = V(location * scale) + self.range.lowerBound
                let clampedValue = max(min(newValue, self.range.upperBound), self.range.lowerBound)
                
                if self.step != nil {
                    let step = V.zero.advanced(by: self.step!)
                    self.value.wrappedValue = round((clampedValue - self.range.lowerBound) / step) * step + self.range.lowerBound
                } else {
                    self.value.wrappedValue = clampedValue
                }
            }
        }
    }
}

