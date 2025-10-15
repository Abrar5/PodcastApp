//
//  HomeView.swift
//  PodcastApp
//
//  Created by Abrar on 14/10/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State var selectedType: ContentType = ContentType.allCases.first ?? .podcast
    
    var body: some View {
        VStack {
            headerView
            filterView
                .padding([.top, .bottom], 16)
            sectionsView
            Spacer()
        }
        .padding()
        .background(.black)
        .onAppear() {
            Task {
                await viewModel.getHomeSections()
            }
        }
    }
    
    private var headerView: some View {
        HStack {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 35, height: 35)
                .foregroundColor(.green)
            
            Text("Good Evening, Abrar")
                .foregroundColor(.white)
            
            Image(systemName: "star.circle.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.yellow)
            
            Spacer()
            
            ZStack(alignment: .topLeading) {
                Image(systemName: "bell")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
                
                Text("4")
                    .font(.caption2)
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color.red)
                    .clipShape(Circle())
                    .offset(x: -5, y: -8)
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private var filterView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(ContentType.allCases, id: \.id) { type in
                    VStack {
                        Text(type.localizedDescription)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(8)
                    .background(selectedType == type ? Color.red : Color.gray.opacity(0.2))
                    .cornerRadius(20)
                    .onTapGesture {
                        selectedType = type
                    }
                }
            }
        }
    }
    
    private var sectionsView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            let filteredAndSortedList = viewModel.homeSections?.sections.filter { $0.contentType == selectedType.rawValue }.sorted(by: { $0.order < $1.order }) ?? []
            ForEach(filteredAndSortedList) { section in
                VStack {
                    HStack {
                        Text(section.name)
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                        Spacer()
                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    SectionDetailView(section: section)
                }
            }
        }
    }
}
