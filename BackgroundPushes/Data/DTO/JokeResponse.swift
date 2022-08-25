//
//  JokeResponse.swift
//  BackgroundPushes
//
//  Created by Jaewon on 2022/08/25.
//

import Foundation

struct JokeResponse: Codable {
    let type: String
    let value: Joke
}

struct Joke: Codable {
    let id: Int
    let joke: String
}
