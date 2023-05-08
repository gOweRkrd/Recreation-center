import SwiftUI

struct MainScreenView: View {
    @StateObject var viewModel = MainScreenViewModel(networkService: NetworkService())
    
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
                                .fill(Color.red)
                                .frame(width: Constants.frameSize, height: Constants.frameSize)
                            Text("\(count)")
                                .customFont(SFProDisplay.medium, category: .large)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .padding(.trailing, Constants.zStackTrailing)
                    }
                }
            }
            .tag(category)
        }
    }
}

// MARK: - Constants

private enum Constants {
    static let frameSize: CGFloat = 40
    static let listRowInsets: CGFloat = 0
    static let zStackTrailing: CGFloat = 5
}
