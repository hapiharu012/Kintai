//
//  ContentView.swift
//  KintaiApp
//
//  Created by k21123kk on 2022/09/06.
//

import SwiftUI
import LocalAuthentication


struct ContentView: View {
  
  @ObservedObject var data = Data()   //ログイン者情報クラスのインスタンス
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  
  @State private var text = ""
  @State private var idText = ""    //社員コードのテキストフィールド変数
  @State private var pwText = ""    //パスワードのテキストフィールド変数
  @State private var isActive = false   //画面遷移の許可
  @State private var passHidden = true    //パスワードを隠蔽の有無
  
  @State private var showingAlert = false   //アラートの有無
  @State private var alertType: AlertType = .alert1   //アラートの種類
  enum AlertType{
    case alert1  //IdもしくはPwが間違っている時
    case alert2  //IdもしくはPwが空文字の時
    case alert3  //サーバ接続エラー
  }
  
  @State private var license = LoginLicense(login: false)   //LoginLicenseのインスタンス
  struct LoginLicense: Codable{    //JSONデータから取得する構造体
    var login: Bool   //apiから取得したloginの許可(真理値)変数の格納
  }
  
  //出退勤メモ
  @State private var showingSheet = false
  @State private var showing1Button = true
  @State private var showing2and3Button = false
  @State private var toggle2to2 = true
  @State private var hidden3Button = false
  
  //生体認証
  @State var Flag = false   //顔認証成功
  //ログイン情報のローカルデータ
  @AppStorage("loginLog") var login = false
  @AppStorage("loginId") var id = "0000"
  @AppStorage("loginPw") var pw = "pass0000"
  
  @AppStorage("TinmeMemo") var text5 = ""
  
  //カレンダー
  @State var hour = Calendar.current.component(.hour, from: Date())
  @State var minute = Calendar.current.component(.minute, from: Date())
  @State var second = Calendar.current.component(.second, from: Date())
  let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
  @State var date = Date()
  
  //  @State private var text5 = ""
  @State private var totalChars = 0
  @State private var lastText = ""
  
  
  var body: some View {
    
    NavigationView(){
      
      VStack{
        Text("F   O   I   S").bold().font(.largeTitle).offset(x:0,y:-90)
        
        VStack{ //入力欄
          VStack{
            Text("社員コード").offset(x: -128,y:0).frame(width: 200,height: 5).font(.footnote)
            TextField("未入力", text : $idText).textFieldStyle(RoundedBorderTextFieldStyle())
              .frame(width: 320, height: 40, alignment: .center).font(.title2)
              .offset(x: 2, y:0)
              .autocapitalization(.none)    // 重ねて表示するための位置調整
          }
          ZStack{
            VStack{
              Text("パスワード").offset(x: -128,y:0).frame(width: 200,height: 5).font(.footnote)
              
              HStack{
                if self.passHidden{ //非表示
                  SecureField("未入力",text: $pwText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 320, height: 40, alignment: .center).font(.title2)
                    .offset(x: 2, y:0)
                }else{  //表示
                  TextField("未入力", text: $pwText).textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 320, height: 40, alignment: .center).font(.title2)
                    .offset(x: 2, y:0)
                }
              }}.padding()
            Image(systemName: self.passHidden ? "eye.slash.fill": "eye.fill")
              .offset(x: 141, y:6)
              .foregroundColor(self.passHidden ? Color.secondary : Color.gray).onTapGesture {
                self.passHidden.toggle()
              }
          }
          
        }.padding(20).offset(x:0,y:-25)
        
        NavigationLink(destination: SecondView(data:data),isActive: $isActive,
                       label: {
          EmptyView()
        })
        //        .navigationTitle("F O I S")  //リンク先を指定
        
        //------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        ZStack{
          Button(action: {
            if(login&&(idText==""||pwText=="")){
              authenticate()
            }else{
              if(idText == "" || pwText == ""){   //入力-無
                showingAlert = true
                alertType = AlertType.alert2    //IdもしくはPwが空文字の時2
              }else{    //入力-有
                getData()   //API接続および解析
                
              }
              
            }
            
          }) {
            Text("ログイン").frame(width: 300, height: 40)
          }.padding()
            .font(.largeTitle)
            .frame(width: 300, height: 40)
            .foregroundColor(Color.white)
            .background(Color(hue: 0.201, saturation: 0.81, brightness: 0.58))
            .cornerRadius(10)
            .offset(x:0,y:-40)
          
          
          
            .alert(isPresented: self.$showingAlert) {  // アラートの表示条件設定
              switch alertType {
              case .alert1:
                return Alert(title: Text("認証失敗"),
                             message: Text("社員コードまたはパスワードが正しくありません。"),
                             dismissButton: .default(Text("OK")))
              case .alert2:
                return Alert(title: Text("ログイン不可"),
                             message: Text("社員コードとパスワードを入力してください。"),
                             dismissButton: .default(Text("OK")))
              case .alert3:
                return Alert(title: Text("サーバ接続エラー"),
                             message: Text("システム管理者へお問い合わせください。"),
                             dismissButton: .default(Text("OK")))
              }
            }
        }
        Text("勤務時間記録").underline().padding().accentColor(colorScheme == .dark ? .white : .black).background(colorScheme == .dark ? .black : .white)
          .frame(width: 300, height: 40)
          .offset(x: 0,y:50).onTapGesture {
            showingSheet = true
          }
          .sheet(isPresented: $showingSheet){
            
            Button(action: {    //ログイン画面に戻る
              showingSheet = false
            }){
              Text("ログイン画面へ").font(.title3)
            }
            VStack{
              Text("\(hour):\(minute):\(second)").onReceive(timer){ _ in
                self.hour = Calendar.current.component(.hour, from: Date())
                self.minute = Calendar.current.component(.minute, from: Date())
                self.second = Calendar.current.component(.second, from: Date())
              }
              
              
              DatePicker(selection: $date, displayedComponents: .date, label: { Text("") } )
                .datePickerStyle(GraphicalDatePickerStyle())
              
              TextEditor(text: $text5)
                .padding()
                .background(Color.yellow.opacity(0.5))
                .foregroundColor(Color.black)
                .font(Font.custom("AvenirNext-Regular", size: 20, relativeTo: .body))
                .frame(width: 300, height: 250)
                .cornerRadius(25)
              
              
            }
            
            //-----------記録ボタン------------------------------------------------------1
            
            HStack{
              if(showing1Button){
                Button(action: {
                  showing2and3Button = true
                  showing1Button = false
                  
                  text5 = "出勤："+String(self.hour)+":"+String(self.minute)+":"+String(self.second)
                }){
                  Text("出勤")
                  
                }
              }
              //-------------------------------------------------------2
              if(showing2and3Button){
                //----------------------------------3
                toggle2to2 ? (
                  Button(action: {
                    toggle2to2.toggle()
                    hidden3Button = true
                    text5 = text5
                    + "\n\n" + "-休憩開始："+String(self.hour)+":"+String(self.minute)+":"+String(self.second)
                  }){
                    Text("休憩開始")
                  }) : (Button(action: {
                    toggle2to2.toggle()
                    hidden3Button = false
                    text5 = text5
                    + "\n" + "-休憩終了："+String(self.hour)+":"+String(self.minute)+":"+String(self.second) + "\n"
                  }){
                    Text("休憩終了")
                  }
                  )
                //----------------------------------3
                
                if(!hidden3Button){
                  Button(action: {
                    showing1Button = true
                    showing2and3Button = false
                    text5 = text5
                    + "\n" + "退勤："+String(self.hour)+":"+String(self.minute)+":"+String(self.second)
                    
                  }){
                    Text("退勤")
                  }
                }
                
              }   //<--if(showing2and3Button)
              //-------------------------------------------------------2
              //------------------------------------------------------------------------------1
            }
            
          }
        
      }
      //------------------------------------------------------------------------------------------------------------------------------------------------------------------------
      
      
      
    }.font(.title).navigationBarHidden(true)
  }
  
  //<--var body: some View
  func authenticate() {
    let context = LAContext()
    var error: NSError?
    
    // Check whether it's possible to use biometric authentication
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
      
      // Handle events
      context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "ログインを簡易化するため。") { success, authenticationError in
        
        if success {
          text = "認証成功"
          pwText = pw
          idText = id
          Flag = true
          
        } else {
          Flag = false
          login = false
          text = "認証失敗"
        }
        check()
      }
    } else {
      Flag = false
      login = false
      text = "Phone does not have biometrics"
    }
  }
  
  func check() {
    if Flag {
      getData()
    }
  }
  
  func getData(){   //API接続および解析
    guard let url = URL(string: "http://<URL省略>/WMI//Api/Login.ashx?LoginUser=\(idText)&LoginPass=\(pwText)") else { return }
    URLSession.shared.dataTask(with: url) {(data, response, error) in
      do {
        if let licenseData = data {
          let decodedData = try JSONDecoder().decode(LoginLicense.self, from: licenseData)
          self.license = decodedData
          licenseCheck()
        } else {
          showingAlert = true
          alertType = AlertType.alert3    //サーバ接続エラー表示
          print("No data", data as Any)
        }
      } catch {
        showingAlert = true
        alertType = AlertType.alert3    //サーバ接続エラー表示
        print("Error1", error)
      }
    }.resume()
  }
  
  func licenseCheck(){    //解析チェックからの処理
    if(!self.license.login){    //認証失敗
      showingAlert = true
      alertType = AlertType.alert1    //IdもしくはPwが間違っている時1
    }else{    //認証成功
      showingAlert = false
      id = idText
      pw = pwText
      data.Id=idText
      data.Pw=pwText
      login = true
      //        idText = ""
      pwText = ""
      
      isActive = license.login
    }
  }
  
}//---->

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ContentView()
    }
  }
}


