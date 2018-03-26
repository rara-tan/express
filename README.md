# README

# express
Twitterの簡易版です。
文字のツイートやユーザフォローだけでなく、画像の投稿やダイレクトメッセージも実施できます。

# 実行環境
* Ruby 2.4.1
* Rails 5.0.6
* MySQL 5.5.58
* ImageMagick 6.7.8-9 (ImageMagickのバージョンに注意)

# セットアップ
```
bundle install --without production
```
```
rails db:migrate
```

# 使い方
* ユーザ登録・ログイン後、マイページでプロフィールを編集する。
* トップページからツイートを投稿する。写真も同時にツイートできる。
* 画面右上の「ユーザを探す」からフォロー・ダイレクトメッセージをしたいユーザを探す。
