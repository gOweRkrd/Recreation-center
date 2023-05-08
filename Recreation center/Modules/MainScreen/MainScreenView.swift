import SwiftUI

struct MainScreenView: View {
    @StateObject var viewModel = MainScreenViewModel(networkService: NetworkService())
    @State var isFavorite: Bool = false
    
    var body: some View {
        setupMainScreenUI
            .preferredColorScheme(.dark)
            .onAppear {
                viewModel.fetchMainScreenView()
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
                HStack {
                    Text(category.name ?? R.MainScreenView.text)
                        .customFont(SFProDisplay.medium, category: .extraLarge)
                    
                    Spacer()
                    
                    if let count = category.count {
                        ZStack {
                            Circle()
                                .fill(category.color ?? .red)
                                .frame(width: Constants.frameSize, height: Constants.frameSize)
                            Text("\(count)")
                                .customFont(SFProDisplay.medium, category: .large)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .padding(.trailing, Constants.zStackTrailing)
                    }
                    viewModel.changeFavoriteButton(for: category)
                }
            }
            .swipeActions(edge: .leading, allowsFullSwipe: false) {
                viewModel.trashButton(for: category)
                viewModel.favoriteButton(for: category)
            }
        }
    }
}

// MARK: - Constants

private enum Constants {
    static let frameSize: CGFloat = 40
    static let listRowInsets: CGFloat = 0
    static let zStackTrailing: CGFloat = 5
}
