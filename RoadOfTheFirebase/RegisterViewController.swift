import UIKit
import Firebase // Firebaseを使用するファイルではここを追加しないと使用できない。

// ユーザーがアカウント登録するための画面
class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    // アカウント登録時に入力するテキストフィールド
    @IBOutlet var emailTextField: UITextField! // メールアドレスのフォーム
    @IBOutlet var passwordTextField: UITextField! // パスワードのフォーム
    @IBOutlet var userNameTextField: UITextField! // ユーザーの名前のフォーム
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        userNameTextField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // すでにログインしているかをチェックする。
        if (UIApplication.shared.delegate as! AppDelegate).isLogin {
            performSegue(withIdentifier: "UserList", sender: nil) // 画面遷移を行う。
        }
    }
    
    // アカウントを登録するメソッド
    @IBAction func register() {
        // 19行目のif文でテキストフィールドに入力不備がないかをチェックしている。
        if emailTextField.text != "", passwordTextField.text != "", userNameTextField.text != "" {
            // 入力不備がないので、アカウントを登録する処理を呼ぶ。
            Auth.auth()
                .createUser( // この下に、アカウントを登録するために必要なメールアドレスと、パスワードを記述する。
                    withEmail: emailTextField.text!,
                    password: passwordTextField.text!
                ) { (result, error) in // Firebase側から「結果」と「エラー」の二つがレスポンスとして返ってくる。
                    // ここで、アカウント登録の処理が完了したときの動きを書く。
                    // エラーがあれば処理を中断する。(return)
                    if error != nil {
                        return
                    }
                    // ユーザーがちゃんと登録されているかもチェックする。
                    if result?.user == nil {
                        return
                    }
                    // エラーがないので、データベースにユーザー名などのアカウント情報を保存する処理を行う。
                    Firestore.firestore()
                        .collection("users") // ここは、保存するデータのグループの名前。
                        .document(result!.user.uid) // ここは、保存するデータのキー。
                        .setData([ // この下に、保存するデータをかく。
                            "email": self.emailTextField.text!,
                            "password": self.passwordTextField.text!,
                            "name": self.userNameTextField.text!
                        ]) { error in // データベースは「エラー」のみをレスポンスとして返してくる。
                            // ここは、データベースの登録が終わったら呼ばれる。
                            // 上と同じようにエラーがないかを確認する。
                            if error != nil {
                                return
                            }
                            // エラーがないので、ユーザー一覧画面に遷移する。
                            self.performSegue(withIdentifier: "UserList", sender: nil)
                    }
            }
        }
    }
    
    // キーボードのリターンキーを押したときに、キーボードを閉じるために記述。
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
