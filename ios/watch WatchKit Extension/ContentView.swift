//
//  ContentView.swift
//  watch WatchKit Extension
//
//  Created by Piotr FLEURY on 20/02/2022.
//

import SwiftUI
import OSLog

struct ContentView: View {
    @ObservedObject var viewModel: WatchViewModel = WatchViewModel()
   
    
    func valueTapped(value: Int) {
        viewModel.swap(value: value)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    TileView(value: viewModel.data[0], action: valueTapped)
                    TileView(value: viewModel.data[1], action: valueTapped)
                    TileView(value: viewModel.data[2], action: valueTapped)
                }
                HStack {
                    TileView(value: viewModel.data[3], action: valueTapped)
                    TileView(value: viewModel.data[4], action: valueTapped)
                    TileView(value: viewModel.data[5], action: valueTapped)
                }
                HStack {
                    TileView(value: viewModel.data[6], action: valueTapped)
                    TileView(value: viewModel.data[7], action: valueTapped)
                    TileView(value: viewModel.data[8], action: valueTapped)
                }
                Text("Counter: \(viewModel.counter)")
                    .padding()
                Button(action: {
                    _send(count: 2)
                }) {
                    Text("+ by 2")
                }
            }
        }
    }
    
    func _send(count: Int) {
        viewModel.sendDataMessage(for: .sendCounterToFlutter, data: ["counter": viewModel.counter + count])
    }
}

