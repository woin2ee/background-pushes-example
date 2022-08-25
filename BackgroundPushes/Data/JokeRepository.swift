//
//  JokeRepository.swift
//  BackgroundPushes
//
//  Created by Jaewon on 2022/08/25.
//

import Foundation
import OSLog

enum NetworkError: Error {
    case someError
}

final class JokeRepository {
    
    private let coreDataStorage = CoreDataStorage.shared
    
    func updateJoke(_ completion: @escaping (Result<Void, NetworkError>) -> Void) {
        guard let url: URL = .init(string: "http://api.icndb.com/jokes/random") else {
            Logger.network.error("Fetch joke failed. (Invalid URL)")
            completion(.failure(.someError))
            return
        }
        
        let request: URLRequest = .init(url: url)
        URLSession.shared.dataTask(
            with: request,
            completionHandler: { data, urlResponse, error in
                guard let data = data else {
                    completion(.failure(.someError))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder.init().decode(JokeResponse.self, from: data)
                    let jokeEntity: JokeEntity = .init(context: self.coreDataStorage.context)
                    jokeEntity.contents = decodedData.value.joke
                    self.coreDataStorage.saveContext()
                    completion(.success(()))
                } catch {
                    completion(.failure(.someError))
                    return
                }
            }
        ).resume()
    }
    
    func fetchJokes() -> [String] {
        do {
            let jokeEntities = try coreDataStorage.context.fetch(JokeEntity.fetchRequest())
            let jokes = jokeEntities.compactMap { $0.contents }
            return jokes
        } catch {
            Logger.coreData.error("CoreData fetch 실패")
            return ["데이터를 가져올 수 없습니다."]
        }
    }
}
