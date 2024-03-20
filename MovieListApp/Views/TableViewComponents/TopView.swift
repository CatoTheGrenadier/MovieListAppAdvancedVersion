//
//  ContentView.swift
//  MovieListApp
//
//  Created by Yi Ling on 2/24/24.
//

import SwiftUI

struct TopView: View {
    @State var Genres = GenresMap()
    @State var DeletedMovies = DeletedMovieIds()
    @ObservedObject var lastMovie = LastMovie()
    @State var updateView = false
    @ObservedObject var appStateVM = AppStateViewModel()
    @State var chosenType: String? = "null"
    @ObservedObject var profileRep = ProfileRepository()
    @State var isEditViewPresented = false
    
    var body: some View {
        if appStateVM.isSignedIn {
            NavigationView{
                List{
                    ScrollView{
                        if lastMovie.category != "null" {
                            TableGrids(type: "popular", DeletedMovies: DeletedMovies,Genres: Genres, lastMovie:lastMovie, profileRep: profileRep)
                            TableGrids(type: "top_rated", DeletedMovies: DeletedMovies, Genres: Genres, lastMovie:lastMovie, profileRep: profileRep)
                            TableGrids(type: "upcoming", DeletedMovies: DeletedMovies, Genres: Genres, lastMovie:lastMovie, profileRep: profileRep)
                            TableGrids(type: "now_playing", DeletedMovies: DeletedMovies, Genres: Genres, lastMovie:lastMovie, profileRep: profileRep)
                        }
                    }
                    .padding(0)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Text(appStateVM.currentUserEmail)
                            Button("Profile"){
                                isEditViewPresented.toggle()
                            }
                            Button{
                                DispatchQueue.main.async{
                                    appStateVM.signOut()
                                    profileRep.unsubscribe()
                                }
                            } label: {
                                Text("Sign Out")
                            }
                        } label: {
                            Image(systemName: "person.fill")
                        }
                    }
                }
                .sheet(isPresented: $isEditViewPresented) {
                    EditProfileView(profileRep: profileRep)
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(appStateVM)
        }
        else {
            LoginView(profileRep:profileRep).environmentObject(appStateVM)
        }
    }
    
}

#Preview {
    TopView()
}
