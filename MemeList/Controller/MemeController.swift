//
//  MemeController.swift
//  MemeList
//
//  Created by Rafael Gonzaga on 10/30/24.
//

import Foundation
import Alamofire

class MemeController {
    
    // Array que armazena os objetos de meme carregados
    private var arrayMemes: [MemeObject] = []
    weak var delegate: MemeControllerProtocol?

    // Método que retorna a quantidade de memes no array
    func count() -> Int {
        // Retorna o número de memes armazenados no arrayMemes
        return self.arrayMemes.count
    }
    
    // Método que retorna o nome do meme com base em um índice (IndexPath)
    func loadCurrentName(indexPath: IndexPath) -> String {
        // Acessa o array arrayMemes na posição correspondente e retorna o nome do meme
        return self.arrayMemes[indexPath.row].name
    }
    
    // Método que também retorna o nome do meme com base em um índice
    // Nota: Este método tem um erro de digitação no nome (deveria ser `loadCurrentName`)
    func laodCurrentName(indexPath: IndexPath) -> String {
        // Acessa o array arrayMemes na posição correspondente e retorna o nome do meme
        return self.arrayMemes[indexPath.row].name
    }
    
    // MARK: Abordagem para tratar requisições com protocolos
    // Essa abordagem usa um protocolo (MemeControllerProtocol) para delegar o tratamento de sucesso e erro da requisição a outra classe.
    func getRequestMemesWithProtocol() {
        
        AF.request("https://api.imgflip.com/get_memes").responseJSON { response in
            if response.response?.statusCode == 200 {
                
                if let data = response.data {
                    do {
                        let memeModel: Meme? = try JSONDecoder().decode(Meme.self, from: data)
                        
                        self.arrayMemes = memeModel?.data.memes ?? []
                        self.delegate?.sucess()
                        
                    }catch {
                        print(error)
                        self.delegate?.failure(error: error)
                    }
                    
                }
            }
            
        }
    }
}
