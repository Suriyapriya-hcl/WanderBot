# WanderBot

WanderBot is an AI-powered travel companion mobile application built with Flutter. It helps users plan trips, discover nearby places, receive travel alerts, scan landmarks, and listen to location-based tourist audio guides from one app.

The project combines AI trip planning, map-based discovery, MongoDB-backed user data, and generated audio narration to make travel planning faster and more personalized.

## Project Overview

Planning a trip usually requires switching between multiple platforms for destinations, hotels, trains, flights, weather, maps, and local information. WanderBot solves this by bringing the main travel workflow into a single mobile app.

Users can:

- Sign up and maintain a travel profile
- Ask an AI assistant to create trip plans
- Search for trains, flights, hotels, and weather
- Discover nearby tourist and local places
- Use AI to scan and understand landmarks
- Listen to generated tourist audio guides
- Save and refine trip plans

## Features

- **AI Travel Assistant**: Chat-based trip planning using natural language.
- **Personalized Itineraries**: Day-wise travel plans with transport, hotels, budget, and booking order.
- **No-Plan Adventure**: Nearby food, hidden gems, scenic places, and short activity suggestions.
- **GeoAudio Guide**: Location-based tourist narration with generated audio.
- **Landmark Lens**: AI vision-based landmark recognition and explanation.
- **Travel Alerts**: Important travel and weather-related alerts.
- **Saved Trips**: Store and view previous trip plans.
- **Multi-language Audio Support**: Tourist narrations can be generated in multiple languages.

## Tech Stack

### Frontend

- Flutter
- Dart
- Provider
- Dio / HTTP
- Google Maps Flutter
- Geolocator
- Just Audio

### Backend

- FastAPI for GeoAudio APIs
- Dart HTTP server for authentication and travel APIs
- Python scripts for train, hotel, and flight lookup automation

### Database and APIs

- MongoDB / MongoDB Atlas
- OpenAI API
- Google Places API
- Google Maps API
- ElevenLabs API

## Project Structure

```text
.
├── android/                 # Android Flutter project
├── backend/                 # FastAPI GeoAudio backend
│   ├── main.py              # GeoAudio API server
│   ├── req.txt              # Python dependencies
│   ├── index.json           # Audio cache index
│   └── audio/               # Cached generated audio files
├── bin/
│   ├── auth_server.dart     # Auth, profile, trips, recommendations backend
│   ├── train_lookup.py      # Train search automation
│   ├── hotel_lookup.py      # Hotel search automation
│   └── flight_lookup.py     # Flight search automation
├── lib/
│   ├── config/              # App configuration
│   ├── models/              # Data models
│   ├── screens/             # App screens
│   ├── services/            # API, auth, AI, location, audio services
│   ├── theme/               # App theme
│   ├── utils/               # Helper utilities
│   └── widgets/             # Reusable UI widgets
├── web/                     # Flutter web files
├── pubspec.yaml             # Flutter dependencies
├── render.yaml              # Render deployment blueprint
└── Dockerfile.auth          # Docker deploy file for Dart backend
```

## End-to-End Workflow

1. The user opens WanderBot and signs up or logs in.
2. Profile data is stored in MongoDB.
3. The user can open the AI chat and request a trip plan.
4. WanderBot collects details like destination, date, number of people, and travel mode.
5. The backend searches for travel options and prepares a personalized itinerary.
6. The user can save, refine, or extend the plan.
7. For nearby exploration, the app uses location data and Google Places.
8. For GeoAudio, the backend generates a tourist narration and converts it into audio.
9. The user listens to the guide directly inside the app.

## Backend APIs

### GeoAudio Backend

Located in `backend/main.py`.

Main endpoints:

```text
GET    /health
GET    /config
POST   /nearby-pois
POST   /prefetch
POST   /trigger
GET    /audio/{filename}
POST   /check-geofence
GET    /ip-location
DELETE /cache
```

### Auth and Travel Backend

Located in `bin/auth_server.dart`.

Main endpoints:

```text
GET  /health
POST /auth/signup
POST /auth/signin
POST /profiles/fetch
POST /profiles/update
POST /destinations/recommendations
POST /news/alerts
POST /trains/search
POST /hotels/search
POST /flights/search
POST /weather/forecast
POST /trips/save
POST /trips/list
```

## Environment Variables

Create a local `.env` file using `.env.example` as reference.

```text
GEOAUDIO_API_URL=http://127.0.0.1:8000
AUTH_API_URL=http://localhost:8080
MONGODB_URI=mongodb://localhost:27017/tourism
OPENAI_API_KEY=your_openai_key
ELEVENLABS_API_KEY=your_elevenlabs_key
GOOGLE_MAPS_API_KEY=your_google_maps_key
```

Do not commit real API keys to a public repository.

## Local Setup

### 1. Install Flutter Dependencies

```bash
flutter pub get
```

### 2. Run GeoAudio Backend

```bash
cd backend
pip install -r req.txt
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

Health check:

```bash
curl http://127.0.0.1:8000/health
```

### 3. Run Auth and Travel Backend

From the project root:

```bash
dart run bin/auth_server.dart
```

Health check:

```bash
curl http://localhost:8080/health
```

### 4. Run Flutter App

```bash
flutter run
```

For Android with Google Maps:

```bash
GOOGLE_MAPS_API_KEY=your_google_maps_key flutter run
```

## Deployment

The repository includes `render.yaml` for Render deployment.

It defines two services:

- `suriya-geoaudio`: FastAPI GeoAudio backend
- `suriya-auth`: Dart auth/travel backend

Required cloud environment variables:

```text
MONGODB_URI=your_mongodb_atlas_uri
OPENAI_API_KEY=your_openai_key
ELEVENLABS_API_KEY=your_elevenlabs_key
GOOGLE_MAPS_API_KEY=your_google_maps_key
```

After deployment, confirm both services:

```bash
curl https://YOUR-GEOAUDIO.onrender.com/health
curl https://YOUR-AUTH.onrender.com/health
```

## Android APK Build

Build a release APK using deployed backend URLs:

```bash
GOOGLE_MAPS_API_KEY=YOUR_GOOGLE_MAPS_KEY flutter build apk --release \
  --dart-define=GEOAUDIO_API_URL=https://YOUR-GEOAUDIO.onrender.com \
  --dart-define=AUTH_API_URL=https://YOUR-AUTH.onrender.com \
  --dart-define=OPENAI_API_KEY=YOUR_OPENAI_KEY
```

APK output:

```text
build/app/outputs/flutter-apk/app-release.apk
```

## Judge Demo Flow

1. Open the app and show login/signup.
2. Show the home dashboard with travel picks and alerts.
3. Open a destination page and explain must-visit places.
4. Show No-Plan Adventure suggestions.
5. Open WanderBot Chat and request a trip plan.
6. Show train, flight, hotel, weather, and itinerary output.
7. Open GeoAudio Guide and show nearby tourist places.
8. Play the generated audio guide.
9. Conclude by explaining how WanderBot reduces manual travel planning.

## Project Explanation

WanderBot is designed as a complete AI travel companion. It combines trip planning, nearby discovery, travel alerts, landmark recognition, and audio tourism into a single mobile experience. Instead of making users search across multiple apps, WanderBot lets them ask naturally, explore instantly, and receive personalized travel help before and during the trip.

## Future Enhancements

- Move all OpenAI calls fully behind the backend for stronger API key protection.
- Add payment or booking partner integrations.
- Improve offline support for saved trips and downloaded audio.
- Add admin dashboard for monitoring usage and cached recommendations.
- Publish through Google Play Console Internal Testing.

## License

This project is intended for academic and demonstration purposes.
