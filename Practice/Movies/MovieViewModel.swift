//
//  MovieViewModel.swift
//  Practice
//
//  Created by Bowen Sun on 2024-04-07.
//

import Foundation

class MovieViewModel: ObservableObject {
    @Published var displayableCat = [CatViewModel]()
    
    private func catFactCallback(completion: @escaping (_ catList: [CatData]) -> Void) {
        guard let url = URL(string: "https://cat-fact.herokuapp.com/facts") else {
            return
        }
        let request = URLRequest.init(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, urlResponse, urlErr in
            if let urlErr = urlErr {
                print(urlErr.localizedDescription)
                return
            }
            guard let data = data else {
                return
            }
            do {
                let catList = try JSONDecoder().decode([CatData].self, from: data)
                completion(catList)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    private func catFactConvertedAsync() async -> [CatData] {
        await withCheckedContinuation { continuation in
            catFactCallback { catList in
                continuation.resume(returning: catList)
            }
        }
    }
    
    private func displayable(_ catList: [CatData]) -> [CatViewModel] {
        return catList.enumerated().map { (index, catData) in
            let dogImgName = 200 + index
            let imgUrl = URL(string: "https://http.dog/\(dogImgName).jpg")
            return CatViewModel.init(id: catData._id, text: catData.text, imgUrl: imgUrl)
        }
    }
    
    public func catFact() {
        Task {
            let catList = await catFactConvertedAsync()
            let converted = displayable(catList)
            print(converted)
        }
    }
    
    public func catFactNativeAsync() {
        Task {
            guard let catUrl = URL(string: "https://cat-fact.herokuapp.com/facts") else {
                return
            }
            do {
                let (data, _) = try await URLSession.shared.data(from: catUrl)
                let catList = try JSONDecoder().decode([CatData].self, from: data)
                let converted = displayable(catList)
                DispatchQueue.main.async {
                    self.displayableCat = converted
                }
            } catch {
                print(error)
            }
        }
    }
}

struct CatData: Codable {
    let _id: String
    let text: String
    let updatedAt: String
    let createdAt: String
}

class CatViewModel: Identifiable, ObservableObject {
    let id: String
    let text: String
    let imgUrl: URL?
    
    @Published var tapped = false
    
    init(id: String, text: String, imgUrl: URL?) {
        self.id = id
        self.text = text
        self.imgUrl = imgUrl
    }
}
