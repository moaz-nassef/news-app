<div align="center">

# 📰 Flutter News App
<p align="center">
  <img src="https://raw.githubusercontent.com/moaz-nassef/news-app/main/screenshots/cover.jpeg" alt="news-app cover" width="720"/>
</p>

<p align="center">
  <a href="#screenshots">
    <img src="https://img.shields.io/badge/View_All_Screenshots-02569B?style=for-the-badge&logo=image&logoColor=white" alt="View all screenshots"/>
  </a>
</p>

> **Your daily news, one tap away — top headlines, curated categories, an in-app reader and a personal favorites list, all in a polished gradient UI.**

[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?style=for-the-badge&logo=flutter&logoColor=white&color=02569B)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.5%2B-0175C2?style=for-the-badge&logo=dart&logoColor=white&color=0175C2)](https://dart.dev)
[![State Management](https://img.shields.io/badge/State-BLoC%20%2B%20Cubits-purple?style=for-the-badge&color=7C6CFF)](https://pub.dev/packages/flutter_bloc)
[![API](https://img.shields.io/badge/API-NewsAPI.org-orange?style=for-the-badge&color=FF5CA8)](https://newsapi.org)
[![Platform](https://img.shields.io/badge/Platform-Android%20%E2%80%A2%20iOS%20%E2%80%A2%20Web-4ECDC4?style=for-the-badge)]
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge&color=4CC38A)]()

</div>

---

## 🚀 What is this app?

A clean, **modern news reader** built with Flutter that turns the raw [NewsAPI](https://newsapi.org) feed into something you actually enjoy reading.

It loads **live top headlines**, lets you **jump between seven curated categories**, opens articles **inside the app** in a dedicated reader (no more tab switching on mobile), and keeps a **favorites list** so the stories you care about are always one screen away.

Everything is wrapped in a **cohesive gradient brand identity** — orange → magenta → deep purple — with **buttery page transitions**, animated card entrances, and a colorful splash that sets the mood.

---

## ✨ Why it feels nice

| Area | What was built |
|---|---|
| 🌈 **Gradient identity** | A signature 3-colour brand (`primary → secondary → tertiary`) reused across the splash title, nav pills, buttons and hero cards. |
| 🎬 **Animated everywhere** | Splash intro with fade+scale, staggered article card entrances, bouncing bottom-nav pills (`easeOutBack`), subtle hover/press feedback. |
| 📄 **In-app reading** | Real `WebView` reader inside the app on mobile/desktop — stays in context while you read. |
| 📱 **Web-friendly fallback** | `WebView` isn't supported on the web, so it smartly opens the article in a new tab instead — no dead ends. |
| 🔁 **Pull-to-refresh** | Refresh top headlines instantly with the native pull gesture. |
| 💜 **Favorites** | Save articles with a heart; the list survives navigation and comes with a friendly empty state. |
| 🧭 **4-tab navigation** | Home · Categories · Explore · Favorites — with animated selected pills. |
| 🌐 **Cross-platform** | Android, iOS and web from a single codebase. |

---

## 🌟 Features

### 🏠 Home — Top Headlines
- Fetches the latest **top headlines** from NewsAPI on launch.
- Hero **"TRENDING NOW"** gradient banner to set the tone.
- Horizontal **category chips** (Business → Technology) for a quick jump.
- **Pull-to-refresh** to reload the news fresh.
- Loading, error (`wifi_off` + **Try again**) and empty states, all handled gracefully.

### 🗂️ Categories
- Seven curated categories: **Business, Entertainment, General, Health, Science, Sports, Technology**.
- A beautiful **2-column grid** of category cards with themed images.
- Tap any card → a dedicated screen listing **all articles for that category**.
- Per-category loading / error / empty handling with retry.

### 📖 Article Reader
- Tap **"Read more"** on any card → the full article opens **inside the app** in a `WebView`.
- Web fallback: opens the article in a **new browser tab** with a friendly notice.
- **Share** any article right from the reader toolbar 📤.

### 💜 Favorites
- Heart icon on every article card — tap to **save / unsave**.
- A dedicated **Favorites screen** shows everything you saved.
- Nice empty state: *"Tap the heart on any article to save it here"*.

### 🎨 UI / Motion
- Custom **`PageTransitionsTheme`**: every navigation fades + slides (`0.06 → 0`) — buttery app-wide.
- **Animated bottom navigation** with gradient pill backgrounds and `easeOutBack` scaling.
- Card **staggered fade-in + slide-up** as articles load.
- Press-and-bounce **gradient buttons** (scale 0.93 on touch).
- Loading **dots spinner** everywhere a fetch is in flight.

---

## 🧱 Tech Stack

| Technology | Why |
|---|---|
| [Flutter](https://flutter.dev) | One codebase — Android, iOS & web |
| [flutter_bloc](https://pub.dev/packages/flutter_bloc) + `bloc` | Predictable, testable state management (Cubits) |
| [http](https://pub.dev/packages/http) | Rest calls to NewsAPI.org |
| [cached_network_image](https://pub.dev/packages/cached_network_image) | Fast, memory-friendly article thumbnails |
| [flutter_animate](https://pub.dev/packages/flutter_animate) | Splash, card & list entrance animations |
| [webview_flutter](https://pub.dev/packages/webview_flutter) | In-app article reader on mobile |
| [url_launcher](https://pub.dev/packages/url_launcher) | Open articles externally (web fallback) |
| [share_plus](https://pub.dev/packages/share_plus) | Share articles from the reader |
| [simple_gradient_text](https://pub.dev/packages/simple_gradient_text) | Gradient headlines & titles |
| [loading_animation_widget](https://pub.dev/packages/loading_animation_widget) | Polished loading spinners |

---

## 🧬 Architecture

Feature-first folder layout — clean separation between **core**, **features** and **data**:

```
lib/
├── main.dart                     # Bootstrap: MultiBlocProvider + theme
├── core/
│   ├── network/                  # NewsAPI client (fetch + parse articles)
│   ├── shared/                   # Bottom nav, buttons, article tiles, loading
│   ├── themes/                   # MyTheme — brand colours, gradient, page transitions
├── features/
│   ├── home/                     # Top headlines — cubit, repo, model, views
│   │   ├── data/                 # ArticleModel + HomeServices (API repo)
│   │   ├── viewModel/            # HomeCubit + HomeState
│   │   ├── views/                # HomeView, FavoriteNews
│   │   └── widgets/              # Gradient hero, HomeBody, Web article reader
│   ├── category/                 # Categories — cubit, repo, views
│   │   ├── viewModel/            # CategoryCubit + CategoryState
│   │   └── views/                # Category grid, per-category article list
│   └── splash/                   # Animated splash → home
└── tool/
    └── news_proxy.dart           # Local CORS proxy for Flutter web builds
```

**Key design decisions:**

- 🧩 **Cubits as the single source of truth** — `HomeCubit` and `CategoryCubit` hold state and drive every screen via `BlocConsumer`.
- 🛠️ **One API client** — `NewsApiClient.fetchTopHeadlines()` is shared by home + categories (with optional `category` param).
- 🧰 **Repos on top** — `HomeServices` and `GetCategoricalArticles` wrap the client so Cubits never touch `http` directly.
- 🖥️ **Web CORS handled** — `newsapi.org` sends no CORS headers, so `tool/news_proxy.dart` forwards requests with the right headers (auto-used only on `kIsWeb`).

---

## ✅ Getting Started

### Prerequisites

- 🦋 Flutter SDK `>= 3.5.0` (Dart 3.5+)
- 🔑 A (free) API key from [newsapi.org](https://newsapi.org/) — replace `apiKey` in `lib/core/network/news_api_client.dart`

> ⚠️ NewsAPI only allows this free key on **localhost** — set **Allowed origins** in your NewsAPI account to `localhost` / the domain you run on.

### Run it (mobile / desktop)

```bash
# 1. Clone
git clone https://github.com/moaz-nassef/news-app.git
cd news_app

# 2. Install dependencies
flutter pub get

# 3. Launch on an emulator / device
flutter run
```

### Run it on the web

The web build needs the tiny CORS proxy (CORS headers are missing from the API):

```bash
# Terminal 1 — start the proxy
dart run tool/news_proxy.dart

# Terminal 2 — run the app
flutter run -d chrome
```

> The app detects `kIsWeb` and routes API calls through `http://127.0.0.1:8090` automatically.

### Build a release

```bash
flutter build apk --release   # 📱 Android
flutter build web             # 🌐 Web
```

---

## 🧪 Tests

```bash
flutter test
```

- ✅ **`widget_test.dart`** — smoke test that the app builds & the splash/home render.

---

## 🗺️ Roadmap

- [x] Top headlines with pull-to-refresh
- [x] 7 curated categories with dedicated article lists
- [x] In-app article reader (`WebView`) + web fallback
- [x] Favorites screen with save/unsave
- [x] Animated splash, nav & card micro-interactions
- [x] Cross-platform (Android / iOS / Web)
- [ ] 🔍 Global keyword search
- [ ] 📚 Browse by source / country
- [ ] 💾 Persist favorites across restarts
- [ ] 🎨 Dark mode

---

## 🤝 Contributing

Contributions are always welcome! 🎉

1. 🍴 Fork the repo
2. 🌿 Create your branch (`git checkout -b feature/amazing`)
3. 💾 Commit (`git commit -m 'Add amazing thing'`)
4. 📤 Push (`git push origin feature/amazing`)
5. 🔀 Open a Pull Request

---

## 🧑‍💻 Author

**Moaz Nassef** — [GitHub](https://github.com/moaz-nassef)

---

<div align="center">

Made with 💜 using Flutter & Dart

⭐ **If you like it, please star the repo!** ⭐

</div>

<!-- SCREENSHOTS-AUTO-START -->
## Screenshots

Below are all the app screenshots. The cover image is shown above; tap the button under it to jump back here.

<p align="center"><img src="https://raw.githubusercontent.com/moaz-nassef/news-app/main/screenshots/%D8%B5%D9%88%D8%B1%D8%A9%201.jpeg" alt="صورة 1" width="200"/>  <img src="https://raw.githubusercontent.com/moaz-nassef/news-app/main/screenshots/%D8%B5%D9%88%D8%B1%D8%A9%202.jpeg" alt="صورة 2" width="200"/>  <img src="https://raw.githubusercontent.com/moaz-nassef/news-app/main/screenshots/%D8%B5%D9%88%D8%B1%D8%A9%203.jpeg" alt="صورة 3" width="200"/></p>
<p align="center"><img src="https://raw.githubusercontent.com/moaz-nassef/news-app/main/screenshots/%D8%B5%D9%88%D8%B1%D8%A9%204.jpeg" alt="صورة 4" width="200"/>  <img src="https://raw.githubusercontent.com/moaz-nassef/news-app/main/screenshots/%D8%B5%D9%88%D8%B1%D8%A9%205.jpeg" alt="صورة 5" width="200"/>  <img src="https://raw.githubusercontent.com/moaz-nassef/news-app/main/screenshots/%D8%B5%D9%88%D8%B1%D8%A9%206.jpeg" alt="صورة 6" width="200"/></p>
<p align="center"><img src="https://raw.githubusercontent.com/moaz-nassef/news-app/main/screenshots/%D8%B5%D9%88%D8%B1%D8%A9%207.jpeg" alt="صورة 7" width="200"/></p>
<!-- SCREENSHOTS-AUTO-END -->
