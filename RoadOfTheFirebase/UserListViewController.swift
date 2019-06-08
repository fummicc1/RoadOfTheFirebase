import Foundation
import UIKit
import Firebase

// ユーザー一覧を表示する画面
class UserListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView! // テーブルビュー
    
    var userNameList: [[String: String]] = [] // データを保存しておく変数。
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // 画面が現れるたびに呼ばれる。viewDidLoadの後に呼ばれる。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        readUserData()
    }
    
    func readUserData() {
        Firestore.firestore()
            .collection("users") // ユーザーというグループからデータを取得する。
            .getDocuments { (snapShots, error) in // 今回は、「users」の中にあるすべてのドキュメントを取得している。
                // ここもエラーが入っていないかをチェックする。
                // snapShotsにはデータベースのデータが入っているので取得していく。
                // 先ずは、snapShotsの中身が入っているかを確認する。
                if snapShots == nil {
                    return
                }
                // 中身が入っているので、データを取得できる。
                for document in snapShots!.documents {
                    let data = document.data()["name"] as! String // データベースから「name」というキーのデータを取得する。
                    self.userNameList.append(["name": data])
                }
                self.tableView.reloadData() // 取得が完了したらでテーブルビューを再度読みこみする。
        }
    }
    
    // セルの個数を決める。
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userNameList.count
    }
    
    // セルの設定画面。セルの個数分だけ呼ばれる。
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        cell.userNameLabel.text = userNameList[indexPath.row]["name"] // セルのUILabelにデータを代入。
        return cell
    }
}
