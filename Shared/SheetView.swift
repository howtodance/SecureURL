//
//  SheetView.swift
//  SecureURLExtension
//
//  Created by Yauheni Baranouski on 06/10/2021.
//

import SwiftUI

struct SheetView: View {
    let url: URL

    @Environment(\.dismiss) var dismiss

    var body: some View {
        
        VStack(alignment: .center) {
            WebView(url: url)
            
            Button("Press to dismiss") {
                dismiss()
            }
            .font(.title)
            .padding()
            .background(Color.clear)
        }
    }
}
