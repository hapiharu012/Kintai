//
//  Data.swift
//  Test2
//
//  Created by k21123kk on 2022/09/14.
//


import SwiftUI

class Data: ObservableObject {    //ログイン者 情報
  @Published var Id = ""    //社員コード
  @Published var Pw = ""    //パスワード
  @Published var idTmp = ""
  @Published var pwTmp = ""

}
