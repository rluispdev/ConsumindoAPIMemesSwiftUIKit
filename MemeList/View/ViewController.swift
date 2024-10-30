//
//  ViewController.swift
//  MemeList
//
//  Created by Rafael Gonzaga on 10/30/24.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var memeTableView: UITableView!
    
    //Array para teste
    var arrayMemes: [MemeObject] = []
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configura o delegate e dataSource da TableView
        self.memeTableView.delegate = self
        self.memeTableView.dataSource = self
        
        //Teste
        // Realiza uma requisição para obter os dados dos memes
        AF.request("https://api.imgflip.com/get_memes").response { response in

            // Verifica se o código de status da resposta é 200 (requisição bem-sucedida)
            if response.response?.statusCode == 200 {
                
                // Verifica se há dados na resposta
                if let data = response.data {
                    do {
                        // Decodifica os dados JSON da resposta para o modelo Meme
                        let memeModel: Meme? = try JSONDecoder().decode(Meme.self, from: data)
                        
                        // Armazena os memes decodificados no array local e recarrega a tabela
                        self.arrayMemes = memeModel?.data.memes ?? []
                        self.memeTableView.reloadData() // Atualiza a tabela com os dados obtidos
                        
                    } catch {
                        // Imprime o erro caso a decodificação falhe
                        print(error)
                    }
                }
            }
        }

    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Retorna a quantidade de memes para definir o número de linhas na tabela
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayMemes.count
    }
    
    // Retorna uma célula configurada com o nome do meme correspondente ao índice da linha
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Define o texto da célula como o nome do meme no índice atual
        cell.textLabel?.text = self.arrayMemes[indexPath.row].name
        return cell
    }
}

 
