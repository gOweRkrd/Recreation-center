import SwiftUI

struct DetailView: View {
    var category: Category?
    @StateObject var viewModel = DetailViewModel()
    @State private var selectedCategory: Category?
    @State private var images: [URL: UIImage] = [:]
    
    var body: some View {
        listDetails
            .navigationBarTitle(Text(R.DetailView.title))
            .listStyle(PlainListStyle())
            .listRowInsets(
                EdgeInsets(
                    top: Constants.listRowInsets,
                    leading: Constants.listRowInsets,
                    bottom: Constants.listRowInsets,
                    trailing: Constants.listRowInsets
                )
            )
            .onAppear {
                selectedCategory = category
                viewModel.fetchDetail(category: selectedCategory)
            }
    }
    
    func loadImage(for item: Object) {
        guard let imageUrl = item.image else { return }
        guard images[imageUrl] == nil else { return }
        
        URLSession.shared.dataTask(with: imageUrl) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                images[imageUrl] = UIImage(data: data)
            }
        }
        .resume()
    }
}

private extension DetailView {
    
    var listDetails: some View {
        List(viewModel.detailModel.filter { $0.type == category?.type }) { item in
            HStack {
                if let imageUrl = item.image {
                    if let image = images[imageUrl] {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: Constants.imageFrameWidth, height: Constants.imageFrameHeight)
                            .cornerRadius(Constants.imageCornerRadius)
                    } else {
                        ProgressView()
                            .frame(width: Constants.imageFrameWidth, height: Constants.imageFrameHeight)
                            .onAppear {
                                loadImage(for: item)
                            }
                    }
                } else {
                    EmptyView()
                        .frame(width: Constants.imageFrameWidth, height: Constants.imageFrameHeight)
                }
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
    }
}

// MARK: - Constants

private enum Constants {
    static let frameSize: CGFloat = 40
    static let listRowInsets: CGFloat = 0
    static let imageFrameWidth: CGFloat = 95
    static let imageFrameHeight: CGFloat = 70
    static let imageCornerRadius: CGFloat = 7
    static let textLeadingPadding: CGFloat = 20
}
