//
//  ModelLoader.swift
//  SecureURLExtension
//
//  Created by Yauheni Baranouski on 07/10/2021.
//

import Foundation
import Combine

class ModelLoader: ObservableObject {
    private var cancellabels = Set<AnyCancellable>()
    @Published private(set) var receivedUrl = ""

    func performRequest() {
        loadLinkModel()
            .sink { models in
                guard let urlString = models.first?.link else {
                    return
                }
                
                self.receivedUrl = urlString
            }
            .store(in: &cancellabels)
    }
    
    private func loadLinkModel() -> AnyPublisher<[LinkModel], Never> {

        let url = URL(string: Constants.publicApiURL)!

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [LinkModel].self, decoder: JSONDecoder())
            .replaceError(with: [LinkModel]())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
