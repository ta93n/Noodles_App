## Noodlesとは
https://noodles-app.com<br>
ラーメン屋さんの写真や情報を友だちと共有できるアプリケーションです。<br>
※公開終了しました。<br><br>
<img width="400" alt="スクリーンショット 2020-12-01 13 42 22" src="https://user-images.githubusercontent.com/57702892/100698340-86f52800-33db-11eb-99c0-f2c6684da5e2.png">
<img width="400" alt="スクリーンショット 2020-12-01 13 42 48" src="https://user-images.githubusercontent.com/57702892/100698336-852b6480-33db-11eb-98b9-27e7549b715d.png">
<img width="400" alt="スクリーンショット 2020-12-01 13 44 27" src="https://user-images.githubusercontent.com/57702892/100698318-7f358380-33db-11eb-9de1-8b9f190ff556.png">
<img width="130" alt="スクリーンショット 2020-12-01 13 51 00" src="https://user-images.githubusercontent.com/57702892/100698671-5c579f00-33dc-11eb-9d5b-d203113ff522.png">
<img width="130" alt="スクリーンショット 2020-12-01 13 51 07" src="https://user-images.githubusercontent.com/57702892/100698676-6083bc80-33dc-11eb-8f62-10eb9152c595.png">
<img width="130" alt="スクリーンショット 2020-12-01 13 51 15" src="https://user-images.githubusercontent.com/57702892/100698678-611c5300-33dc-11eb-9365-3f5d96a95cbd.png">
## 機能一覧
- ユーザー機能
  - 新規登録（メール送信によるユーザー認証）、ログイン、ログアウト機能ほか<br>
- 投稿機能
  - 一覧表示、詳細表示、投稿、編集、削除
  - 画像アップロードはCarrierWave
  - 画像拡大表示(LightBox)
  - 詳細表示内に地図、コメント機能(Ajax)、twitter/facebook/lineシェアボタン
  - **店名・最寄駅情報から位置情報を取得**<br>まとめ→https://qiita.com/nideratakumin/items/5574d9f38616a03f04c6
  - 投稿者がお店・ラーメンを☆で評価可能
  - セレクトボックスによるソート機能<br>
- お気に入り機能(Ajax)
  - お気に入り登録した投稿の一覧表示<br>
- フォロー機能(Ajax)
  - フォロー、フォロワーの一覧表示<br>
- 投稿検索機能
  - キーワード検索フォーム設置
  - **地図上から投稿検索可能**<br>
- ラーメンのジャンル毎に投稿表示<br>
- **全面的にレスポンシブ化(ハンバーガーメニュー)**<br>
- RSpecによる自動テスト(単体・統合)<br>
## 使用技術
- フロントエンド
  - HTML, SCSS, Bootstrap, jquery, javascript<br>
- バックエンド
  - Ruby 2.6.5
  - Rails 6.0.3.1<br>
- DB
  - MySQL 5.7.30<br>
- webサーバー・アプリケーションサーバー
  - Nginx
  - Unicorn<br>
- インフラ・開発環境等
  - AWS（VPC, EC2, RDS, S3, Route 53, ALB, ACM）
  - Docker/docker-compose(ローカル開発環境)
  - CircleCI(自動ビルド、自動テスト、自動デプロイ)
  - Capistrano(自動デプロイ)
  - RSpec(テストフレームワーク)
  - rubocop(静的コード解析ツール)
  - Git, GitHub
  - Google Maps Platform
## ER図
  ![201029_ER図_Noodles (2)](https://user-images.githubusercontent.com/57702892/99798915-2b25d600-2b75-11eb-8a26-db396dabdd42.jpg)
## インフラ構成図
  ![200909_インフラ構成図](https://user-images.githubusercontent.com/57702892/92624114-179ef900-f302-11ea-811f-7ba8d22cd373.jpg)
## 制作背景
誰もが楽しんで使えるサービスを作りたいと思いました。<br>
みんな大好きなラーメン、何気なく写真を撮ってはTwitterに投稿するだけでしたが、<br>
食べたラーメンを記録し、一覧で見返したり、友だちと共有できれば<br>
よりラーメンを楽しむことができるのではと考えました。
## 今後の予定
issueに記載
