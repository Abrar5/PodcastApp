//
//  SectionDetailView.swift
//  PodcastApp
//
//  Created by Abrar on 15/10/2025.
//

import SwiftUI

struct SectionDetailView: View {
    var section: SectionEntity
    @State private var shouldShowDetails = false
    
    var body: some View {
        switch section.displayStyle {
        case .square:
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(section.viewableContent) { content in
                        SquareView(content: content)
                            .onTapGesture {
                                shouldShowDetails = true
                            }
                            .sheet(isPresented: $shouldShowDetails) {
                                MoreDetailsViewRepresentable(content: content)
                                    .presentationDetents([.fraction(0.80)])
                            }
                    }
                }
            }
            
        case .twoLinesGrid:
            let twoRowLayout: [GridItem] = [
                GridItem(.flexible()),
                GridItem(.flexible())
            ]
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: twoRowLayout, spacing: 16) {
                    ForEach(section.viewableContent) { content in
                        TwoLinesGridView(content: content)
                            .frame(width: 300)
                            .onTapGesture {
                                shouldShowDetails = true
                            }
                            .sheet(isPresented: $shouldShowDetails) {
                                MoreDetailsViewRepresentable(content: content)
                                    .presentationDetents([.fraction(0.80)])
                            }
                    }
                }
                .padding(.horizontal)
            }
            .frame(height: 250)
            
        case .bigSquare, .big_Square:
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(section.viewableContent) { content in
                        BigSquareView(content: content)
                            .onTapGesture {
                                shouldShowDetails = true
                            }
                            .sheet(isPresented: $shouldShowDetails) {
                                MoreDetailsViewRepresentable(content: content)
                                    .presentationDetents([.fraction(0.80)])
                            }
                    }
                }
            }
            
        case .queue:
            QueueView(section: section)
            
        case .none:
            EmptyView()
        }
    }
}

struct BigSquareView: View {
    var content: ViewableContent
    var body: some View {
        VStack() {
            
            ImageLoaderView(url: content.imageUrl)
                .frame(width: 300, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading) {
                Text(content.name)
                    .lineLimit(1)
                    .foregroundColor(.white)
                    .font(AppFonts.medium(size: 14))
                
                Text(content.episodeCount)
                    .lineLimit(1)
                    .foregroundColor(.white)
                    .font(AppFonts.text(size: 12))
            }
            .frame(alignment: .leading)
        }
    }
}

struct SquareView: View {
    var content: ViewableContent
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ImageLoaderView(url: content.imageUrl)
            
            Text(content.name)
                .lineLimit(1)
                .foregroundColor(.white)
                .font(AppFonts.medium(size: 14))
                .frame(alignment: .leading)
            
            HStack(spacing: 8) {
                HStack(spacing: 5) {
                    Image(systemName: "play.circle.fill")
                        .foregroundColor(.white)
                    Text(content.duration)
                        .foregroundColor(.white)
                        .font(.caption)
                        .font(AppFonts.extraLight(size: 6))
                }
                .padding(8)
                .background(.gray.opacity(0.2))
                .cornerRadius(20)
                
                Spacer()
            }
            .frame(alignment: .leading)
        }
        .frame(width: 150, height: 200, alignment: .leading)
    }
    
}

struct TwoLinesGridView: View {
    var content: ViewableContent
    
    var body: some View {
        HStack(spacing: 8) {
            ImageLoaderView(url: content.imageUrl)
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(content.name)
                    .foregroundColor(.white)
                    .font(AppFonts.medium(size: 14))
                
                // Duration Capsule
                HStack(spacing: 5) {
                    Image(systemName: "play.circle.fill")
                        .foregroundColor(.white)
                    Text(content.duration)
                        .foregroundColor(.white)
                        .font(.caption)
                        .font(AppFonts.extraLight(size: 6))
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(.gray.opacity(0.2))
                .cornerRadius(20)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct QueueView: View {
    var section: SectionEntity
    
    var body: some View {
        HStack(spacing: 8) {
            ZStack(alignment: .bottomTrailing) {
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(section.viewableContent.first?.name ?? "")
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(3)
                            .font(AppFonts.medium(size: 14))
                        
                        Text(section.viewableContent.first?.duration ?? "")
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(AppFonts.extraLight(size: 12))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .foregroundColor(.white)
                        .padding(.trailing, 0)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            ZStack {
                if section.viewableContent.count > 2 {
                    ImageLoaderView(url: section.viewableContent[2].imageUrl)
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .rotationEffect(.degrees(5))
                        .offset(x: 20, y: 5)
                        .opacity(0.7)
                }
                
                if section.viewableContent.count > 1 {
                    ImageLoaderView(url: section.viewableContent[1].imageUrl)
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .rotationEffect(.degrees(-3))
                        .offset(x: 10, y: 0)
                        .opacity(0.9)
                }
                
                ImageLoaderView(url: section.viewableContent.first?.imageUrl ?? "")
                    .frame(width: 90, height: 90)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .frame(width: 120, height: 120)
        }
        .padding(15)
        .background(Color(white: 0.15))
        .cornerRadius(12)
        .foregroundColor(.white)
        .frame(width: 350, height: 150)
    }
}
