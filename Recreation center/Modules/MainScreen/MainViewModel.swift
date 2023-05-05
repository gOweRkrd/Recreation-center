import SwiftUI

final class MainViewModel: ObservableObject {
    
    @Published var categories: [Category] = [
        Category(name: R.MainViewModel.entertainments, color: .red, number: R.MainViewModel.eight),
        Category(name: R.MainViewModel.food, color: .orange, number: R.MainViewModel.six),
        Category(name: R.MainViewModel.forChildren, color: .gray, number: R.MainViewModel.one),
        Category(name: R.MainViewModel.souvenirs, color: .green, number: R.MainViewModel.one)
    ]
    
}
