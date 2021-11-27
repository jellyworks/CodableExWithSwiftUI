//
//  ContentView.swift
//  CodableExWithSwiftUI
//
//  Created by Jason on 2021/11/27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
    
    func decode(){
        let jsonData = """
            {
                "count":3,
                "datas":[
                    {
                        "no":1,
                        "name":"Kim"
                    },
                    {
                        "no":2,
                        "name":"Kim"
                    },
                    {
                        "no":3
                    }]
            }
            """.data(using: .utf8)
        
    }
    
    
    
}

struct Person:Codable{
    var num:Int
    var name:String?
    enum CodingKeys:String, CodingKey{
        case num = "no"
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        num = try container.decode(Int.self, forKey: .num)
        name = try container.decodeIfPresent(String.self, forKey: .name)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
