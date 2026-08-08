# ChatterBox AI

A Flutter AI chat app (Gemini-style) with light/dark themes, onboarding, and a chat UI ready to connect to your own backend AI proxy.

## Features

- **Onboarding flow** — splash → onboarding → chat.
- **Chat UI** — message bubbles, input with send/clear, reversed list; accessible labels.
- **Gemini aesthetics** — brand blue palette, light & dark themes.
- **Notifications (planned)** — daily reminder to chat.
- **AI service via backend proxy** — the app never holds an API key; see Security below.

## Security notice

**API keys must never be stored in client-side Flutter applications.** Any key embedded in a Flutter app — whether through `.env` files, compile-time variables, or source code — can be extracted from the built application.

This application requires a **backend proxy** to handle AI API calls securely. The Flutter app sends user messages to your backend, and the backend calls the AI service with the API key stored in server-side secrets.

**Chat currently shows a safe "AI service is not configured" message until a proxy is deployed.**

### Required backend endpoint

```
POST /api/chat
Content-Type: application/json

Request:
{ "message": "user's chat message" }

Response (success):
{ "response": "AI model's response text" }

Response (error):
{ "error": "human-readable error message" }
```

Security requirements: server-side secret storage, authentication, rate limiting (e.g., 30 req/min/user), input length limits, allowed-origin restrictions, and safe error logging. Recommended platforms: Firebase Cloud Functions, Cloud Run, Supabase Edge Functions, or NestJS.

## Usage

1. `flutter pub get`
2. Deploy the backend proxy (see `.env.example`)
3. `flutter run`

## Project structure

```
lib/
├── core/
│   ├── theme/        # ThemeNotifier (Riverpod), light/dark ThemeData
│   └── utils/        # assets, common helpers
├── features/
│   ├── auth/         # onboarding screen
│   └── chat_gemini/  # home/chat screen, Message model
└── test/             # 17 passing tests
```

State management: **Riverpod** (`ProviderScope` + `StateNotifierProvider`). Navigation: imperative `Navigator`.

## Contributing

Contributions are welcome — open an issue or submit a PR.

## License

All rights reserved. Demo/portfolio project.