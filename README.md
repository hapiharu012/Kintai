# Kintai
![fois](https://github.com/hapiharu012/Kintai/assets/120043995/83f47ed9-6f07-4244-a115-726e54099290)
## 概要

「Kintai」はインターンシップで開発した既存の勤怠システムにアクセススマホからFaceIDを使ってログインでき、従来のシステムの不便な点を解決したiOSアプリです。  
  
Kintaiは
**"勤怠システムへのアクセスの新しい手段"**
を提供するアプリです。  
  
  
## 従来のシステムの問題点及び解決策
- PC専用設計であるためスマホからの利用時に操作がしにくい  
  ➡️タブバーでの画面遷移  

- 毎回手動で出勤・退勤・休憩時刻を入力する必要があるため、手間がかかるだけでなく、誤入力の可能性もある  
  ➡️出退勤及び休憩時間のメモ機能


## 機能
- Face IDでのログインに対応  
- 操作をスマホに最適化  
- 勤務時間のメモが可能  
- ダークモードに対応  
## 各画面
- ログイン画面
<img src="https://github.com/hapiharu012/Kintai/assets/120043995/f75adb9b-a533-4c8d-9278-abf6ba316811" height="500">

- 勤務時間メモ画面
<img src="https://github.com/hapiharu012/Kintai/assets/120043995/993d5ba2-407c-4f21-b5ce-5fadcc03e643" height="500">

- 勤怠システム画面  
(実際は既存のシステムが表示される))
<img src="https://github.com/hapiharu012/Kintai/assets/120043995/39a420d6-d96c-4470-be6c-a9eae557643e" height="500">

## 使用技術  
- 顔認証  
➡️LocalAuthenticationフレームワーク  
- ログイン認証  
➡️WebAPI  
- 従来のシステムへのアクセス  
➡️WebView  
## 言語
Swift

## フレームワーク
SwiftUI  
＊APIはインターン先で用意していただいたものなのでコード内では省略しております。なお機能とUIについての簡単な資料がありますのでリンクの方から参照していただけるとありがたいです。 

## アプリの起動
1. `$ git clone https://github.com/hapiharu012/VoiceMemo`
2. `$ cd VoiceMemo`
3. `$ cd OnseiMemo `  
4. `$ xed .`  
5. 上記のコマンドでプロジェクトが開かれるので
    Xcodeで、Xcodeウィンドウの上部にあるツールバーの利用可能なシミュレータのリストから目的のシミュレータを選択します。
6. Xcode で `Cmd + R` を押してプロジェクトを実行します。

  


  
