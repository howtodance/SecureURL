//
//  ContentView.swift
//  Shared
//
//  Created by Yauheni Baranouski on 27/05/2021.
//

import SwiftUI
import Combine

enum Constants {
    static let publicApiURL = "https://techcrunch.com/wp-json/wp/v2/posts?per_page=1&context=embed"
}

struct ContentView: View {
    @State private var localInputURL: String = "https://netguru.com"
    @State private var isShowingWebViewFromRemote: Bool = false
    @State private var isShowingWebViewFromLocal: Bool = false

    @ObservedObject private var modelLoader = ModelLoader()

    var body: some View {
        VStack(alignment: .center) {
            VStack(alignment: .center) {
                Text("It will make request to:")
                    .foregroundColor(.red)
                Text("\(Constants.publicApiURL)")
                    
                Text("Try to change it link value using Charles")
                    .foregroundColor(.red)
            }
            .multilineTextAlignment(.center)
            .padding()
            
            Button {
                modelLoader.performRequest()
            } label: {
                Text("Make request")
            }
            .padding()
            
            VStack(alignment: .center) {
                Text("Received URL:")
                    .foregroundColor(.red)
                Text(modelLoader.receivedUrl)
            }
            .multilineTextAlignment(.center)
            .padding()
            
            Button {
                isShowingWebViewFromRemote = isSecureUrl(urlToOpen: modelLoader.receivedUrl)
            } label: {
                Text("Open url")
            }
            .sheet(isPresented: $isShowingWebViewFromRemote, onDismiss: nil) {
                if let secureURL = URL(secureUrlString: modelLoader.receivedUrl) {
                    SheetView(url: secureURL)
                }
            }
            .padding()
            
            Text("OR")
                .font(.title)
                .padding()
            
            Text("Check if URL contains in allowed URL list.")
                .multilineTextAlignment(.center)
            TextField("Enter URL with protocol like: https://yourdomain.com", text: $localInputURL)
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
                .padding()
            if isSecureUrl(urlToOpen: localInputURL) {
                Text("Contains in whitelist!")
                    .foregroundColor(.green)
                    .padding()
            } else {
                Text("Not contains in whitelist!")
                    .foregroundColor(.red)
                    .padding()
            }
            Button {
                isShowingWebViewFromLocal = isSecureUrl(urlToOpen: localInputURL)
            } label: {
                Text("Open url")
            }
            .sheet(isPresented: $isShowingWebViewFromLocal, onDismiss: nil) {
                if let secureURL = URL(secureUrlString: localInputURL) {
                    SheetView(url: secureURL)
                }
            }
            .padding()
        }
    }

    private func isSecureUrl(urlToOpen: String) -> Bool {
        return URL.init(secureUrlString: urlToOpen) != nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
