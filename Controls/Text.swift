import SwiftUI

struct VersionText: View {
    
    var body: some View {
        let appVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? Defaults.version
        Text("\(appVersion)")
            .font(Styling.caption2Mono)
            .frameStretch(Alignment.bottomTrailing)
            .padding(6)
    }
}
