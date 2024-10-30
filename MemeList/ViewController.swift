//
//  ViewController.swift
//  MemeList
//
//  Created by Rafael Gonzaga on 10/30/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var memeTableView: UITableView!
    
    //Array para teste
    let arrayMemes: [String] = ["Meme1", "Meme2", "Meme3"]
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configura o delegate e dataSource da TableView
        self.memeTableView.delegate = self
        self.memeTableView.dataSource = self
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
        cell.textLabel?.text = self.arrayMemes[indexPath.row]
        return cell
    }
}

 
