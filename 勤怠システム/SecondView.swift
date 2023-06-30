//
//  SecondView.swift
//  test
//
//  Created by k21123kk on 2022/09/20.
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
//          "http://192.168.11.100/WMI/View/WMI0200.aspx?LoginUser=\(data.Id)&LoginPass=\(data.Pw)"
     "https://www.google.fr/"
  }
  @State private  var url: String = ""
  @State private var urlChange = false   //true: url  false: baseUrl
//  print(colorScheme)

  var body: some View {

    ZStack{
//      Rectangle().foregroundColor(Color(hue: 1.0, saturation: 0.024, brightness: 1.0, opacity: 0.986))    //背景に色をつけるため
      
      VStack{
//        Rectangle().foregroundColor(.white).frame(width: 400,height: 100).padding(-10)    //ヘッダー部分を確保するため
//        Divider()   //ヘッダー部とWebViewの境界線を引くため
        WebView(url: (urlChange ? url: baseUrl))    //三項演算子 (true: urlの表示  false: baseUrlの表示)
        
//        Text("id:"+data.Id+"pw:"+data.Pw).bold()
        
        HStack {
          Spacer()
          VStack{
            
            Image(systemName: "person.badge.clock.fill").resizable().scaledToFit().frame(width: 35, height: 50).foregroundColor(colorScheme == .dark ? .white : .black).offset(x:-70,y:0).onTapGesture {
//              self.url = "http://192.168.11.100/WMI/View/WMI0200.aspx?LoginUser=\(data.Id)&LoginPass=\(data.Pw)"//1
              self.url = "https://www.amazon.co.jp/"
              urlChange = true
            }
            Text("実績").font(.caption).offset(x:-68,y:-10)
          }
          VStack{
          Image(systemName: "bell.fill").resizable().scaledToFit().frame(width: 35, height: 50).foregroundColor(colorScheme == .dark ? .white : .black).offset(x:-30,y:0).onTapGesture {
//            self.url = "http://192.168.11.100/WMI/View/WMI0011.aspx"//2
            self.url = "https://timetreeapp.com/"
            urlChange = true
          }
            Text("通知").font(.caption).offset(x:-30,y:-10)
          }
          VStack{
          Image(systemName: "star.square.fill").resizable().scaledToFit().frame(width: 35, height: 50).foregroundColor(colorScheme == .dark ? .white : .black).offset(x:10,y:0).onTapGesture {
//            self.url = "http://192.168.11.100/WMI/View/WMI0210.aspx"//3
            self.url = "https://www.youtube.com/"
            urlChange = true
          }
          Text("CP").font(.caption).offset(x:10,y:-10)
        }
        VStack{
          Image(systemName: "pencil.circle.fill").resizable().scaledToFit().frame(width: 35, height: 50).foregroundColor(colorScheme == .dark ? .white : .black).offset(x:50,y:0).onTapGesture {
//            self.url = "http://192.168.11.100/WMI/View/WMI0300.aspx"//4
            self.url = "https://developer.apple.com/jp/news/"
            urlChange = true
          }
        Text("申請").font(.caption).offset(x:50,y:-10)
      }
          Spacer()
        }.offset(x:10,y: 0)
        
        
      }
      
    }
//    .edgesIgnoringSafeArea(.all)
  }
}


struct SecondView_Previews: PreviewProvider {
  static var previews: some View {
    SecondView()
  }
}
