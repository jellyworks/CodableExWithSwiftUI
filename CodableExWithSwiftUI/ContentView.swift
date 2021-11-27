//
//  ContentView.swift
//  CodableExWithSwiftUI
//
//  Created by Jason on 2021/11/27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            Button {
                decode()
            } label: {
                Text("Decoding")
            }
        }
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
        let decoder = JSONDecoder()
        guard let data = jsonData,
            let personData = try? decoder.decode(PersonData.self, from: data)
        else { return }
        let count = personData.count
        print(count)
        let persons = personData.persons
        for person in persons{
            print("num=\(person.num)")
            if let name = person.name {
                print("name=\(name)")
            }
        }
    }
}

struct PersonData:Codable{
    var count:Int
    var persons:[Person]
    enum CodingKeys:String, CodingKey{
        case count
        case persons = "datas"
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
