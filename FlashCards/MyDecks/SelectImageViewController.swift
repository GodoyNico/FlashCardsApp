import UIKit

class SelectImageViewController: UIViewController {
    
    @IBOutlet weak var imagem: UIImageView!
    @IBAction func botaoEscolher(_ sender: Any) {

        EscolherImagem().selecionadorImagem(self){ imagem in
            self.imagem.image = imagem
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}
