import SwiftUI

struct MainScreenView: View {
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        setupMainScreenUI
            .preferredColorScheme(.dark)
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
        List(viewModel.categories) { category in
            NavigationLink(destination: DetailView(category: category.name)) {
                HStack {
                    Text(category.name)
                        .customFont(SFProDisplay.medium, category: .extraLarge)
                        .foregroundColor(.white)
                    Spacer()
                    ZStack {
                        Circle()
                            .fill(category.color)
                            .frame(width: Constants.frameSize, height: Constants.frameSize)
                        Text(category.number)
                            .customFont(SFProDisplay.medium, category: .large)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
            }
            .listRowBackground(Color.black)
        }
    }
}

// MARK: - Constants

private enum Constants {
    static let frameSize: CGFloat = 40
    static let listRowInsets: CGFloat = 0
    
}
