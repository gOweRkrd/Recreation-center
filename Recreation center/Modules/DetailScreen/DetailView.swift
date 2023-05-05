import SwiftUI

struct DetailView: View {
    
    var category: String
    
    var body: some View {
        Text("Детали категории \(category)")
            .navigationBarTitle(Text("Объекты"), displayMode: .inline)
    }
}
