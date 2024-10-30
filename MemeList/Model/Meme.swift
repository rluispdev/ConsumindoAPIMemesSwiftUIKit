//
//  Meme.swift
//  MemeList
//
//  Created by Rafael Gonzaga on 10/30/24.
//

import Foundation


// Estrutura principal que contém o status de sucesso e os dados dos memes
struct Meme: Codable {
    let success: Bool
    let data: MemeData
}

// Estrutura para representar os dados dos memes, que é uma lista de memes
struct MemeData: Codable {
    let memes: [MemeObject]
}

// Estrutura para representar um objeto Meme individual
struct MemeObject: Codable {
    let id, name: String
    let url: String
    let width, height, boxCount: Int

    enum CodingKeys: String, CodingKey {
        case id, name, url, width, height
        case boxCount = "box_count"
    }
}
