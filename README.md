# samurai17-dev
samurai2017の開発を支援してくれるDockerコンテナ

## 1. What's this?

samurai2017(samurai-jockey)の環境導入を支援するためのDockerコンテナです。
以下の人を対象にしています。

* 自分でmake環境を作るのが面倒。環境依存のエラーが嫌。PC汚したくない。
* とりあえずDockerは入れている。
* よくわからんけど、とりあえずサンプルをいじってみようと思う。

なお、以下のソースを**コンテナ構築時**に引き取っています。  
https://github.com/SamurAI-Coding/Software2017-18

## 2. Install

dockerをインストールした状態で、このリポジトリをcloneするかdocker-compose.ymlをローカルにコピーする。  
docker-compose.ymlのあるディレクトリで、`docker-compose up -d`を実行するとコンテナが立ち上がります。  
初期起動時はgit cloneとmakeがあるので少し時間がかかります。  
とりあえず以下を叩けばいいです。

```
git clone http://github.com/makotookamura/samurai17-dev samurai
cd samurai
docker-compose up -d
```

## 3. How to use

### 0. コンテナ起動直後

container起動直後にdocker-compose.ymlのあるフォルダにdataというディレクトリが出来ます。  
その中にプログラムや設定ファイルなどが一式入っています。詳細はREADME-jp.txtを読んでください。

なお、README-jp.txtに書かれていないファイル、ディレクトリがいくつかありますが、この後、使い方を説明します。


### 1. myAIを作る

playerディレクトリをコピーしてmyAIという名前にして保存する。  
```
cd data
cp -r player myAI
```

### 2. myAIをmake対象に追加

make_player.shを開いて、以下の行を追加する。  
`make -C myAI/ -k`

これにより、myAIを修正したらrunするときに必ずmakeが走るようになります。

### 3. 自分のplayerをraceにエントリーする

race_settings.txtを開いて、AI1かAI2を以下のように変更します。  
```
AI1=myAI/greedy
AI1_NAME=myAI
```

### 4. myAIをいじる

myAIディレクトリのgreedy.cppあたりをガチャガチャ弄ってみてください。

### 5. レースを開始する

raceの開始方法は以下のような方法があります。

1. コンテナを再起動する

docker-compose.ymlがある場所で以下のコマンドを叩いてdocker-composeをリスタートすると、自動的にmakeしてraceを実行してくれます。  
`docker-compose restart`

コンテナ落ちたら、`docker-compose up -d`です。

2. コンテナに入って直接シェルを叩く。

samuraiというフォルダにdocker-compose.ymlを置いている場合は以下のコマンドでコンテナに入れます。  
`docker exec -it samurai_official_1 sh`

コンテナに入ったら/samuraiにいると思うので、以下のコマンドを叩いてください。  
`sh /run_samurai.sh`

なお、抜けるときは**Ctrl+Z**です。

### 6. レース結果を見る

viewerディレクトリのviewer.htmlをブラウザで開いてください。  
Load logボタンを押して、data/logディレクトリの*.racelogを選択してください。  
レースが見れます。


あとは、4-6を繰り返すだけです。最強のAIを作ってみてください！
