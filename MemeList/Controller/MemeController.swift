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
    
    // Método que realiza uma requisição para obter dados de memes de uma API
    func getRequestMemes(completionHandler: @escaping (Bool, Error?) -> Void) {
        
        // Envia uma requisição para obter os dados dos memes da URL fornecida
        AF.request("https://api.imgflip.com/get_memes").response { response in
            
            // Verifica se o código de status da resposta é 200 (requisição bem-sucedida)
            if response.response?.statusCode == 200 {
                
                // Verifica se a resposta contém dados
                if let data = response.data {
                    do {
                        // Tenta decodificar os dados JSON da resposta para o modelo Meme
                        let memeModel: Meme? = try JSONDecoder().decode(Meme.self, from: data)
                        
                        // Se a decodificação foi bem-sucedida, armazena os memes no array local
                        // Caso o memeModel contenha memes, eles são adicionados ao arrayMemes
                        self.arrayMemes = memeModel?.data.memes ?? []
                        
                        // Informa ao completion handler que a operação foi bem-sucedida
                        completionHandler(true, nil)
                        
                    } catch {
                        // Caso ocorra um erro na decodificação, imprime o erro
                        print(error)
                        
                        // Informa ao completion handler que a operação falhou, passando o erro
                        completionHandler(false, error)
                    }
                }
            }
        }
    }
}
