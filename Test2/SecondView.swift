//
//  SecondView.swift
//  test
//
//  Created by k21123kk on 2022/09/08.
//

import SwiftUI
import WebKit


struct WebView: UIViewRepresentable {
  let url: String

  func makeUIView(context: Context) -> WKWebView{
    return WKWebView()
  }

  func updateUIView(_ uiView: UIViewType, context: Context) {
    uiView.load(URLRequest(url: URL(string: url)!))
  }
}


struct SecondView: View {
  @ObservedObject var data = Data()
  @Environment(\.colorScheme) var colorScheme: ColorScheme
   private var baseUrl: String {
          "http://<URL省略>LoginUser=\(data.Id)&LoginPass=\(data.Pw)"     //***URLはインターン先のAPIであり、省略しているため有効なURLに置き換えないとエラーが発生します***
//     "https://www.google.fr/"
  }
  @State private  var url: String = ""
  @State private var urlChange = false   //true: url  false: baseUrl

  var body: some View {

    ZStack{
      
      VStack{
        WebView(url: (urlChange ? url: baseUrl))    //三項演算子 (true: urlの表示  false: baseUrlの表示)
        

        
        HStack {
          Spacer()
          VStack{
            
            Image(systemName: "person.badge.clock.fill").resizable().scaledToFit().frame(width: 35, height: 50).foregroundColor(colorScheme == .dark ? .white : .black).offset(x:-70,y:0).onTapGesture {
              self.url = "http://<URL省略>LoginUser=\(data.Id)&LoginPass=\(data.Pw)"//1
              urlChange = true
            }
            Text("実績").font(.caption).offset(x:-68,y:-10)
          }
          VStack{
          Image(systemName: "bell.fill").resizable().scaledToFit().frame(width: 35, height: 50).foregroundColor(colorScheme == .dark ? .white : .black).offset(x:-30,y:0).onTapGesture {
            self.url = "http://<URL省略>LoginUser=\(data.Id)&LoginPass=\(data.Pw)"//2
            urlChange = true
          }
            Text("通知").font(.caption).offset(x:-30,y:-10)
          }
          VStack{
          Image(systemName: "star.square.fill").resizable().scaledToFit().frame(width: 35, height: 50).foregroundColor(colorScheme == .dark ? .white : .black).offset(x:10,y:0).onTapGesture {
            self.url = "http://<URL省略>LoginUser=\(data.Id)&LoginPass=\(data.Pw)"//3
            urlChange = true
          }
          Text("CP").font(.caption).offset(x:10,y:-10)
        }
        VStack{
          Image(systemName: "pencil.circle.fill").resizable().scaledToFit().frame(width: 35, height: 50).foregroundColor(colorScheme == .dark ? .white : .black).offset(x:50,y:0).onTapGesture {
            self.url = "http://<URL省略>LoginUser=\(data.Id)&LoginPass=\(data.Pw)"//4
            urlChange = true
          }
        Text("申請").font(.caption).offset(x:50,y:-10)
      }
          Spacer()
        }.offset(x:10,y: 0)
        
        
      }
      
    }
  }
}


struct SecondView_Previews: PreviewProvider {
  static var previews: some View {
    SecondView()
  }
}
