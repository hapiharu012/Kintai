//
//  WidgetKintai.swift
//  WidgetKintai
//
//  Created by k21123kk on 2022/11/25.
//

import WidgetKit
import SwiftUI
import Intents
//import WebKit

//struct WebView: UIViewRepresentable {
//  let url: String
//
//  func makeUIView(context: Context) -> WKWebView{
//    return WKWebView()
//  }
//
//  func updateUIView(_ uiView: UIViewType, context: Context) {
//    uiView.load(URLRequest(url: URL(string: url)!))
//  }
//}


struct Provider: IntentTimelineProvider {
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(date: Date(), configuration: ConfigurationIntent(),
                message:"placeholder")
  }
  
  func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
    let entry = SimpleEntry(
      date: Date(),
      configuration: configuration,
      message:"snapshot"
    )
    completion(entry)
  }
  
  func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    var entries: [SimpleEntry] = []
    
    // Generate a timeline consisting of five entries an hour apart, starting from the current date.
    let currentDate = Date()
    //        for hourOffset in 0 ..< 5 {
    //            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
    ////            let entry = SimpleEntry(date: entryDate, configuration: configuration)
    //          let entry = SimpleEntry(date: entryDate, configuration: configuration,
    //                                  message:"s")
    //            entries.append(entry)
    //        }
    entries.append(contentsOf: [
      SimpleEntry(date: Calendar.current.date(byAdding: .second,value: 5,to: currentDate)!, configuration: configuration, message: "11時から会議です"
                 ),
      SimpleEntry(date: Calendar.current.date(byAdding: .second,value: 5,to: currentDate)!, configuration: configuration, message: "12時から会議です"
                 ),
      SimpleEntry(date: Calendar.current.date(byAdding: .second,value: 5,to: currentDate)!, configuration: configuration, message: "13時から会議です"
                 ),
    ])
    
    let timeline = Timeline(entries: entries, policy: .atEnd)
    completion(timeline)
  }
}

struct SimpleEntry: TimelineEntry {
  let date: Date
  let configuration: ConfigurationIntent
  let message:String
}

struct WidgetKintaiEntryView : View {//widget表示
  var entry: Provider.Entry
  
  var body: some View {
    VStack{
                Text(entry.date, style: .time).background(.blue).padding()
                Text(entry.message).background(.blue)
      
//      let components = DateComponents(minute: 15)
//      let futureDate = Calendar.current.date(byAdding: components, to: Date())!
//      Text("timer")
//      Text(futureDate, style: .timer)
      
      //        WebView(url: "https://www.google.fr/")
    }
    
  }
}

struct WidgetKintai: Widget {
  let kind: String = "WidgetKintai"
  
  var body: some WidgetConfiguration {
    IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
      WidgetKintaiEntryView(entry: entry)
    }
    .configurationDisplayName("My Widget")
    .description("This is an example widget.")
  }
}

struct WidgetKintai_Previews: PreviewProvider {
  static var previews: some View {
    WidgetKintaiEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(),
                                             message:"ssss"))
    .previewContext(WidgetPreviewContext(family: .systemSmall))
  }
}
