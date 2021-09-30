//
//  ContentView.swift
//  Shared
//
//  Created by Yauheni Baranouski on 27/05/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var url: String = "https://netguru.com"

    var body: some View {
        VStack(alignment: .center) {
            TextField("Enter URL with protocol like http://youtdomain.com", text: $url)
                .multilineTextAlignment(.center)
            if isSecureUrl() {
                Text("Contains in whitelist!")
                    .foregroundColor(.green)
            } else {
                Text("Not contains in whitelist!")
                    .foregroundColor(.red)
            }
        }
    }


    private func isSecureUrl() -> Bool {
        return URL.init(secureUrlString: url) != nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
