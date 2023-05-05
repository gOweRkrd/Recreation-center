import SwiftUI

struct DetailView: View {
    var category: Category?
    @StateObject var viewModel = DetailViewModel()
    @State private var selectedCategory: Category?
    
    var body: some View {
        listDetails
            .onAppear {
                selectedCategory = category
                viewModel.fetchDetail(category: selectedCategory)
            }
    }
}

// MARK: - Views

private extension DetailView {
    
    var listDetails: some View {
        List(viewModel.items.filter { $0.type == category?.type }) { item in
            HStack {
                Image(item.image ?? "")
                    .resizable()
                    .frame(width: Constants.imageFrameWidth, height: Constants.imageFrameHeight)
                    .cornerRadius(Constants.imageCornerRadius)
                VStack(alignment: .leading) {
                    Text(item.name ?? "")
                        .customFont(SFProDisplay.medium, category: .extraLarge)
                        .lineLimit(2)
                    Text(item.description ?? "")
                        .customFont(SFProDisplay.medium, category: .medium)
                        .lineLimit(2)
                }
                .padding(.leading, Constants.textLeadingPadding)
            }
            .listRowBackground(Color.black)
        }
        .navigationBarTitle(Text("Объекты"))
    }
}
// MARK: - Constants

private enum Constants {
    static let frameSize: CGFloat = 40
    static let listRowInsets: CGFloat = 0
    static let imageFrameWidth: CGFloat = 85
    static let imageFrameHeight: CGFloat = 60
    static let imageCornerRadius: CGFloat = 7
    static let textLeadingPadding: CGFloat = 15
}
