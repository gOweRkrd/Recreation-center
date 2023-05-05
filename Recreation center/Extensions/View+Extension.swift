import SwiftUI

extension View {
    func customFont(_ font: SFProDisplay, category: ContentSizeCategory) -> some View {
        return self.customFont(font.rawValue, category: category)
    }
    
    func customFont(_ name: String, category: ContentSizeCategory) -> some View {
        return self.font(.custom(name, size: category.size))
    }
}
