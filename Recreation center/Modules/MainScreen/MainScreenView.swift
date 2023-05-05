import SwiftUI

struct MainScreenView: View {
    @StateObject var viewModel = MainScreenViewModel()
    
    var body: some View {
        setupMainScreenUI
            .preferredColorScheme(.dark)
            .onAppear {
                viewModel.fetchCategories()
            }
    }
}

// MARK: - Views

private extension MainScreenView {
    
    var setupMainScreenUI: some View {
        NavigationStack {
            listCategories
                .navigationBarTitle(Text(R.MainScreenView.title))
                .listStyle(PlainListStyle())
                .listRowInsets(
                    EdgeInsets(
                        top: Constants.listRowInsets,
                        leading: Constants.listRowInsets,
                        bottom: Constants.listRowInsets,
                        trailing: Constants.listRowInsets
                    )
                )
        }
    }
    
    var listCategories: some View {
        List(viewModel.categories, id: \.name) { category in
            NavigationLink(destination: DetailView(category: category)) {
                Text(category.name ?? "Unknown name")
                    .customFont(SFProDisplay.medium, category: .extraLarge)
            }
            .tag(category)
        }
    }
}

// MARK: - Constants

private enum Constants {
    static let frameSize: CGFloat = 40
    static let listRowInsets: CGFloat = 0
}
