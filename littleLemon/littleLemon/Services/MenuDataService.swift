import Foundation
import Combine

class MenuDataService {
    @Published var items: [MenuItem] = []
    var cancellable: AnyCancellable?
    
    init() {
        downloadData()
    }
    
    private func downloadData() {
        guard let url = Bundle.main.url(forResource: "jsonData", withExtension: "md") else { return }
//        guard let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/littleLemonSimpleMenu.json") else { return }
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { output in
                
//                guard let response = output.response as? HTTPURLResponse,
//                      200...299 ~= response.statusCode else {
//                    throw URLError(.badServerResponse)
//                }
                return output.data
            }
            .decode(type: MenuList.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case let .failure(error) = completion {
                    print("\(#function): \(#line): \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] menuList in
                self?.items = menuList.items
                self?.cancellable?.cancel()
            }
    }
}
