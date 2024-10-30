//
//  ViewController.swift
//  MemeList
//
//  Created by Rafael Gonzaga on 10/30/24.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    // Instancia a classe MemeController, que gerencia a lógica de dados dos memes
    var controller: MemeController = MemeController()
   
    // Conecta a TableView no Storyboard com o código
    @IBOutlet weak var memeTableView: UITableView!
    
   // Array de memes para teste local (pode ser substituído pelos dados carregados pela controller)
        var arrayMemes: [MemeObject] = []
         
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Define o delegate e dataSource da memeTableView como a própria ViewController
            // Isso permite que a TableView utilize os métodos implementados nesta classe para gerenciar os dados e eventos de célula
            self.memeTableView.delegate = self
            self.memeTableView.dataSource = self
            
            // Chama o método getRequestMemes da classe MemeController para buscar os memes da API
            self.controller.getRequestMemes { response, error in
                if response == true {
                    // Recarrega a TableView para exibir os dados obtidos
                    self.memeTableView.reloadData()
                } else {
                    // Caso ocorra um erro, imprime o erro no console
                    print(error ?? "Erro desconhecido")
                }
            }
        }
    }


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Define o número de linhas na tabela com base na quantidade de memes disponíveis
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        // Acessa o método count() através da variável controller, que é uma instância da classe MemeController
        // Isso retorna a quantidade de memes armazenados em arrayMemes na MemeController
        return self.controller.count()
    }
    
    // Retorna uma célula configurada com o nome do meme correspondente ao índice atual (indexPath)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Reutiliza uma célula com o identificador "cell" para otimizar a performance da tabela
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Define o texto da célula como o nome do meme na posição atual
        // Acessa o método loadCurrentName() usando a variável controller, que é uma instância de MemeController
        // Esse método retorna o nome do meme com base no índice fornecido por indexPath
        cell.textLabel?.text = self.controller.loadCurrentName(indexPath: indexPath)
        return cell
    }
}


