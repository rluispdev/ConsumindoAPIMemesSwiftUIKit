//
//  ViewController.swift
//  MemeList
//
//  Created by Rafael Gonzaga on 10/30/24.
//

import UIKit
import Alamofire

protocol MemeControllerProtocol: AnyObject{
    func sucess()
    func failure(error: Error)
}

class ViewController: UIViewController {

    // Instancia a classe MemeController, que gerencia a lógica de dados dos memes
    var controller: MemeController = MemeController()
    
    weak var delegate: MemeControllerProtocol?
   
    // Conecta a TableView no Storyboard com o código
    @IBOutlet weak var memeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Define o delegate do controller para receber callbacks de sucesso ou falha
        self.controller.delegate = self
        
        // Configura o delegate e dataSource da TableView
        self.memeTableView.delegate = self
        self.memeTableView.dataSource = self
        
        // Realiza a requisição para buscar os memes usando o protocolo
        self.controller.getRequestMemesWithProtocol()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Retorna a quantidade de memes para definir o número de linhas na tabela
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.controller.count()
    }
    
    // Retorna uma célula configurada com o nome do meme correspondente ao índice da linha
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Define o texto da célula como o nome do meme no índice atual
        cell.textLabel?.text = self.controller.loadCurrentName(indexPath: indexPath)
        
        return cell
    }
}

extension ViewController: MemeControllerProtocol {
    
    // Método chamado ao obter sucesso na requisição de memes, recarrega a tabela com os dados
    func sucess() {
        self.memeTableView.reloadData()
    }
    
    // Método chamado ao ocorrer um erro na requisição, imprime o erro no console
    func failure(error: Error) {
        print(error)
    }
}
