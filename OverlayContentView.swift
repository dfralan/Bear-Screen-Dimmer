import SwiftUI

struct OverlayContentView: View {
    @State private var isEditMode = false
    @State private var opacity: Double = 0.25
    
    var body: some View {
        VStack {
            if isEditMode {
                Text("Edit Mode Active")
                    .foregroundColor(.yellow)
                    .font(.caption)
                    .padding(.top, 4)
                
                VStack(spacing: 8) {
                    Text("Transparencia: \(Int(opacity * 100))%")
                        .foregroundColor(.white)
                        .font(.caption2)
                    
                    Slider(value: $opacity, in: 0.1...1.0, step: 0.05)
                        .frame(width: 150)
                        .accentColor(.yellow)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            RoundedRectangle(cornerRadius: isEditMode ? 8 : 0)
                .fill(Color.black.opacity(opacity))
                .overlay(
                    RoundedRectangle(cornerRadius: isEditMode ? 8 : 0)
                        .stroke(isEditMode ? Color.yellow.opacity(0.6) : Color.clear, lineWidth: 2)
                )
        )
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("EditModeChanged"))) { notification in
            if let isEdit = notification.object as? Bool {
                isEditMode = isEdit
            }
        }
    }
}

#Preview {
    OverlayContentView()
}