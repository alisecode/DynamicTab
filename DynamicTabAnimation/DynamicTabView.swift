//
//  DynamicTabView.swift
//  DynamicTabAnimation
// Thanks to _kavsoft for the inspiration
//  Created by Alisa Serhiienko on 02.01.2024.
//

import SwiftUI

struct DynamicTabView: View {
    
    @State private var currentTab: Tab = Tab.preview[0]
    @State private var tabs: [Tab] = Tab.preview
    
    @State private var contentOffset: CGFloat = 0
    
    @State private var bottomLineWidth: CGFloat = 0
    @State private var bottomLineXOffset: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .center) {
            TabView(selection: $currentTab) {
                ForEach(tabs) { tab in
                    GeometryReader { _ in
                        // Your content
                    }
                    .clipped()
                    .ignoresSafeArea()
                    .offsetX {
                        offsetXChanged($0, tab: tab)
                    }
                    .tag(tab)
                    
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea()

            .overlay(alignment: .center, content: {
                VStack(alignment: .leading) {
                    Text("Dynamic\nTab Animation")
                        .foregroundStyle(.secondary)
                        .fontWeight(.bold)
                        .font(.system(size: 44))
                        .padding(.horizontal, 16)
                        .offset(y: -16)
                        .overlay(alignment: .topTrailing) {
                            Text("*")
                                .font(.system(size: 56))
                                .foregroundStyle(.red)
                                .offset(x: -98, y: -32)
                        }
                        
                    makeTabView()
                }
                
               
            })
            .preferredColorScheme(.dark)

        }
        
        
    }
    
    private func offsetXChanged(_ rect: CGRect, tab: Tab) {
        if currentTab == tab, let tabIndex = tabs.firstIndex(of: tab) {
            contentOffset = rect.minX - (rect.width * CGFloat(tabIndex))
        }
        
        let inputRange = tabs.indices.compactMap { index -> CGFloat? in
            return CGFloat(index) * rect.width
        }
        
        let outputRangeForWidth = tabs.compactMap { tab -> CGFloat? in
            return tab.width
        }
        
        let outputRangeForPosition = tabs.compactMap { tab -> CGFloat? in
            return tab.minX
        }
        
        let widthInterpolation = Utils(outputRange: outputRangeForWidth, inputRange: inputRange)
        
        let positionInterpolation = Utils(outputRange: outputRangeForPosition, inputRange: inputRange)
        
        bottomLineWidth = widthInterpolation.calculate(for: -contentOffset)
        bottomLineXOffset = positionInterpolation.calculate(for: -contentOffset)
    }
    

    @ViewBuilder
    func makeTabView() -> some View {
        HStack(spacing: 0) {
            ForEach($tabs) { $tab in
                Text(tab.title)
                    .fontWeight(.semibold)
                    .font(.system(size: 22))
                    .foregroundStyle(currentTab.id == $tab.wrappedValue.id ? .white : .secondary)
                    .onTapGesture {
                        withAnimation {
                            bottomLineXOffset = tab.minX
                            bottomLineWidth = tab.width
                            currentTab = tab
                        }
                        
                    }
                    .animation(.easeInOut, value: currentTab)
                    .offsetX { rect in
                        tab.minX = rect.minX
                        tab.width = rect.width
                    }
                
                if tabs.last != tab {
                    Spacer(minLength: 0)
                }
            }
        }
        .padding([.top, .horizontal], 24)
        .overlay(alignment: .leading) {
            Rectangle()
                .frame(width: bottomLineWidth, height: 3)
                .offset(x: bottomLineXOffset, y: 30)
            
        }
    }
}

#Preview {
    DynamicTabView()
}

