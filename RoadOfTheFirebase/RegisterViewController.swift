import UIKit

// ユーザーがアカウント登録するための画面
class RegisterViewController: UIViewController {

    // アカウント登録時に入力するテキストフィールド
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var userNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // アカウントを登録するメソッド
    @IBAction func register() {
    }
}

