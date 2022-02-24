//
//  WebView.swift
//  Menew
//
//  Created by Luca Beetz on 18.02.22.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        let view: WKWebView = WKWebView()
        view.load(URLRequest(url: URL(string: url)!))
        return view
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        //uiView.load(URLRequest(url: URL(string: url)!))
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: "https://www.galileo-erlangen.de/wp-content/uploads/SpeisekarteOnline.pdf")
    }
}
