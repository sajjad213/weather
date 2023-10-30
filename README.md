# Weather App

You could search for a place and see the current weather conditions and also the next five-day forecast.

## Architecture
The app architecture is `MVVM` and it uses `SwiftUI` for building user interface.

## Networking
It uses built-in `URLSession` for networking. 
For each feature, we have an API protocol that should be implemented and injected into its view model.
