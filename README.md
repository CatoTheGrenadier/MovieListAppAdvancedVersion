My Movie List App is a personal project that I have successfully completed. It is a user-friendly application designed for managing movie collections. Below is an overview of the key features and components of the app:

1. TMDB Integration:

I have created an account on The Movie Database (TMDB) platform and obtained an API key for accessing their movie database.
The app seamlessly integrates with TMDB API endpoints to fetch movie data, including Now Playing, Popular, Top Rated, and Upcoming movies.
Each movie entry retrieved from the API contains essential information such as title, rating, description, and poster/backdrop images.
App Features:

2. Quality of Design:
   
The app boasts a visually appealing and intuitive design, adhering to modern design principles.

(1) Layout:
The layout is responsive and flexible, ensuring optimal usability across different devices and orientations.
A Master/Detail flow is implemented, featuring a list view for browsing movies and a detail view for accessing comprehensive movie details.
Custom row views enhance the presentation of movie entries in the list view, providing an engaging browsing experience.

(2) MVVM Design Pattern:
The app follows the Model-View-ViewModel (MVVM) design pattern, ensuring a clean and organized codebase for scalability and maintainability.
Models are defined to handle the retrieval and parsing of movie JSON data, seamlessly integrating with the app's user interface.

(3) Persistence and Archive:
The app offers persistence functionality, allowing users to seamlessly resume their movie browsing experience from where they left off.
Movie data is archived using JSON encoding and decoding to accurately reflect any user-initiated deletions, ensuring data consistency across sessions.
