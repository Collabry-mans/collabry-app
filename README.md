# 📚 Collabry

A **LinkedIn-style Flutter app** for **researchers** to publish, connect, and collaborate seamlessly. Designed with clean architecture, robust authentication, and a modern UI/UX.
<p align="left">
  <img src="https://github.com/user-attachments/assets/4943ea54-8d7a-44af-aa61-a07b9dafd3fe" alt="Collabry Main Image" width = '800'/>
</p>

## 🚀 Features

- 🔐 **Secure Authentication**
  - Full RESTful API integration with login, registration, forget password, and token refresh.
  - Credentials securely stored using `flutter_secure_storage`.
  - `Hive` is used to persist lightweight, fast local data such as:
      - Whether the user has completed onboarding
      - If the user is logged in or not (for silent login)
      - Any app-level local flags or preferences

<p align="left">
  <img src="https://github.com/user-attachments/assets/5ff730ad-825a-4251-ad8e-d621a8ec7e37" alt="Authentication Feature" width = '800'/>
</p>

------------------------------------------------------------------------------------------------------------------------------------

- 🤖 **AI Chatbot**
  - Smart in-app assistant to help researchers navigate, find collaborators, or answer academic queries.

<p align="left">
  <img src="https://github.com/user-attachments/assets/252e21bf-3368-4c25-a21d-f7a09ac95bc1" alt="AI Chatbot Feature"width = '800'/>
</p>

---

- 💬 **Real-Time Chat & Live Collaboration**
  - Engage with fellow researchers via chat.
  - Join or host live sessions for idea sharing or feedback.

<p align="left">
  <img src="https://github.com/user-attachments/assets/8736ed6c-da5a-40ed-8e38-e5b6b04d1b57" alt="Chat & Live Feature"width = '800'/>
</p>

---

- 📚 **Publication Feed by Category**
  - Discover research work sorted by fields of interest.
  - Stay updated with what peers are publishing.

- 🙋 **Editable User Profiles**
  - Add links, bio, expertise, and more.
  - Quick in-app navigation between user publications, draft, and saved posts.

<p align="left">
  <img src="https://github.com/user-attachments/assets/20b6a7b1-9a0b-42b3-b83c-7ec4990b8019" alt="Other App Pages"width = '800'/>
</p>

---

## ⚙️ Tech Stack & Architecture

| Area                  | Description                                                                                       |
|-----------------------|---------------------------------------------------------------------------------------------------|
| 🧱 **State Management** | [Cubit](https://pub.dev/packages/flutter_bloc) from the Bloc package for predictable state control |
| 🔄 **Architecture**     | Clean Architecture with a **layered structure** (data, domain, presentation)                    |
| 🔗 **Dependency Injection** | [get_it](https://pub.dev/packages/get_it) for service location and DI                          |
| ⚠️ **Error Handling**     | `Result` pattern to handle failures and successes gracefully                                   |
| 🔐 **Secure Storage**     | [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) for secure local data |
| 🗃️ **Local Data Storage**   | [Hive](https://pub.dev/packages/hive) for persisting login state, onboarding display, and app preferences   |

---

## 📂 Folder Structure
<pre>
.
└── 📁lib/
    ├── 🔧core/
    │   ├── api/
    │   ├── database/
    │   ├── errors/
    │   ├── functions/
    │   ├── routes/
    │   ├── services/
    │   ├── singleton/
    │   ├── utils/
    │   └── widgets/
    ├── 📦 features/
    │   ├── ai_chat_bot/
    │   │   ├── data/
    │   │   │   ├── models/
    │   │   │   └── repository/
    │   │   └── presentation/
    │   │       ├── manager/
    │   │       ├── views/
    │   │       └── widgets/
    │   ├── authentication/
    │   │   ├── data/
    │   │   │   ├── models/
    │   │   │   └── repository/
    │   │   └── presentation/
    │   │       ├── manager/
    │   │       ├── views/
    │   │       └── widgets/
    │   ├── community/
    │   │   ├── data/
    │   │   │   ├── models/
    │   │   │   └── repository/
    │   │   └── presentation/
    │   │       ├── manager/
    │   │       ├── views/
    │   │       └── widgets/
    │   ├── home_page/
    │   │   ├── data/
    │   │   │   ├── models/
    │   │   │   └── repository/
    │   │   └── presentation/
    │   │       ├── manager/
    │   │       ├── views/
    │   │       └── widgets/
    │   ├── on_boarding/
    │   │   ├── data/
    │   │   │   ├── models/
    │   │   │   └── repository/
    │   │   └── presentation/
    │   │       ├── manager/
    │   │       ├── views/
    │   │       └── widgets/
    │   └── profile/
    │       ├── data/
    │       │   ├── models/
    │       │   └── repository/
    │       └── presentation/
    │           ├── manager/
    │           ├── views/
    │           └── widgets/
    ├── 📄 collabry_app.dart
    └── 📄 main.dart
</pre>
