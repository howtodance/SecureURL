//
//  ContentView.swift
//  Shared
//
//  Created by Yauheni Baranouski on 27/05/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var url: String = "https://netguru.com"
    @State private var isShowingWebView: Bool = false

    var body: some View {
        VStack(alignment: .center) {
            TextField("Enter URL with protocol like http://youtdomain.com", text: $url)
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
                .padding()
            if isSecureUrl() {
                Text("Contains in whitelist!")
                    .foregroundColor(.green)
                    .padding()
            } else {
                Text("Not contains in whitelist!")
                    .foregroundColor(.red)
                    .padding()
            }
            Button {
                isShowingWebView = isSecureUrl()
            } label: {
                Text("Open url")
            }
            .sheet(isPresented: $isShowingWebView, onDismiss: nil) {
                if let secureURL = URL(secureUrlString: url) {
                    SheetView(url: secureURL)
                }
            }
            .padding()
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


