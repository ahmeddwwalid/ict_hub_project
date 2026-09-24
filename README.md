# ICT Hub Project - Flutter E-Commerce App

A Flutter shop app on the live [accessories-eshop API](https://accessories-eshop.runasp.net/openapi/v1.json):
onboarding, login/sign-up with email verification, products, categories, a
server-side cart, and a dark/light theme.

Built with the same structure and patterns as
[ict_hub_flutter_app](https://github.com/Kareemm0/ict_hub_flutter_app):
Cubit + GetIt + GoRouter + Dio + fpdart + Freezed + SharedPreferences.

## Features

- **Onboarding** — shows on first launch only (no splash screen); finishing
  or skipping it stores `isAppOpen` in local storage.
- **Auth** — `POST auth/login` returns a token that is saved to local storage
  and sent as `Authorization: Bearer …` on every request. Sign up
  (`auth/register`) emails a code that the OTP screen verifies
  (`auth/verify-email`). A `401` clears the token and returns to login.
- **Products** — list and details from `GET products` / `GET products/{id}`.
- **Categories** — chips built from the products' categories; picking one
  asks the API for that category (`GET products?category=…`).
- **Cart** — add from the list or the details screen (`POST cart/items`),
  change quantity (`PUT cart/items/{id}`), remove (`DELETE cart/items/{id}`),
  with a total and a badge on the Cart tab.
- **Settings** — theme toggle and logout.

## Project Structure

```
lib/
├── main.dart                     # App entry: DI, app-wide cubits, router
├── injection_container.dart      # GetIt registrations (InjectionHelper)
├── app/
│   ├── app_router.dart           # GoRouter + StatefulShellRoute tabs
│   └── routes.dart               # Route names
├── core/
│   ├── constant/local_keys.dart  # isAppOpen, accessToken, refreshToken
│   ├── cubit/theme/              # ThemeCubit
│   ├── local_storage/            # BaseLocalStorage (abstract)
│   ├── network/api/              # ApiConsumer, Endpoints, StatusCodes
│   ├── network/error/            # Exceptions, Failures
│   ├── utils/                    # AppTheme, Validators
│   └── widget/                   # Shared widgets
├── data/
│   ├── data_source/abstract/     # Auth / Product / Cart data sources
│   ├── data_source/impl/
│   ├── external/dio/             # DioConsumer, AppInterceptors (token)
│   ├── external/local_storage/   # SharedPreferences implementation
│   └── repos/                    # Repo implementations
├── domain/
│   ├── models/                   # Freezed + json_serializable models
│   └── repos/                    # Repo contracts
└── presentation/
    ├── cubit/                    # auth, products, product_details, cart
    ├── layout/main_layout.dart   # Bottom tabs + cart badge
    └── screens/
```

## Getting Started

```bash
flutter pub get
dart run build_runner build
flutter run
```

On **Windows**, building with plugins needs symlink support: turn on
*Developer Mode* (`start ms-settings:developers`) once.

On **Chrome**, run from the project folder with `flutter run -d chrome`.
The API doesn't send CORS headers, so browsers block direct calls to it; in
debug web runs the app calls `/api/` on its own origin and the Flutter dev
server forwards it to the API (`web_dev_config.yaml`). A deployed
`flutter build web` has no such proxy and needs CORS enabled on the API.

## Tests

```bash
flutter test                                   # unit + widget tests (fake API)
flutter test integration_test -d windows       # real app against the live API
```

## Author

Ahmed Walid
GitHub: [@ahmeddwwalid](https://github.com/ahmeddwwalid)
