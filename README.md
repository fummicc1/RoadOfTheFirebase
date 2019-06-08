# RoadOfTheFirebase
FirebseAuthでアカウント登録と、Firestoreのデータベースへの基本的な読み書きを行ったサンプルプロジェクト。

# FirebaseFirestoreの使いかた

## 読みこみ

- 「fummicc1」というキーであるドキュメントを取得。(単体取得)

```swift
Firestore.firestore().collection("users").document("fummicc1").getDocument { (snapShot, error) in
    // 処理
}
```

- usersコレクション内の全てのドキュメントを取得。(全取得)
```swift
Firestore.firestore().collection("users").getDocuments { (snapShots, error) in
    // 処理
}
```

## 書き込み

usersコレクションに新しく「fummicc1」というキーのドキュメントを作成する。

```swift
Firestore.firestore().collection("users").document("fummicc1").setData(
    [
        "user_name": "ふみっち",
        "gender": "Otoko"
    ])
```

# FirebaseAuthの使いかた

## アカウント作成

```swift
var email: String = "sample@gmail.com"
var password: String = "123456"
Auth.auth().createUser(withEmail: email, password: password, completion: { (result, error) in
    // 処理
})
```

## もうすでにログインしているかどうかのチェック
```swift
if Auth.auth().currentUser == nil { 
    // まだログインしていない
} else {
    // すでにログインしている。
}
```
