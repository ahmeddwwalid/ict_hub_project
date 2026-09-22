# ICT Hub Project - Flutter E-Commerce App

A beautiful Flutter e-commerce application with modern UI, authentication flow, product browsing, categories, and settings.

## Features

### Authentication
- **Login Screen**: Email and password validation with mock authentication
- **Sign Up Screen**: User registration with password confirmation
- **OTP Verification**: Email verification with OTP code (mock: use 1234)
- **Session Management**: Logout functionality from settings

### Products
- **Product Listing**: Browse all products with images, titles, categories, and prices
- **Product Details**: View detailed information about each product with add to cart functionality
- **Mock Data**: Pre-loaded products from various categories (Electronics, Bags, Home)

### Categories
- **Category Filtering**: Filter products by category (Electronics, Bags, Home)
- **Category Chips**: Interactive category selection with visual feedback
- **Grouped Products**: Products organized and displayed by their category

### Settings
- **Theme Toggle**: Switch between dark and light modes (UI framework ready)
- **App Info**: Display app version and current theme status
- **Logout**: Secure logout with confirmation dialog
- **User Preferences**: Centralized preferences management

### UI/UX
- Dark theme by default
- Bottom navigation for easy screen navigation
- Smooth animations and transitions
- Responsive design that works on all screen sizes
- Consistent color scheme and typography

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── models/
│   └── product.dart            # Product data model
└── screens/
    ├── login_screen.dart       # Authentication
    ├── signup_screen.dart      # User registration
    ├── otp_verification_screen.dart  # Email verification
    ├── product_screen.dart     # Main product listing with bottom nav
    ├── product_details_screen.dart   # Product details view
    ├── categories_screen.dart  # Category filtering
    └── settings_screen.dart    # User settings
```

## Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK

### Installation

1. Clone the repository:
```bash
git clone https://github.com/ahmeddwwalid/ict_hub_project.git
cd ict_hub_project
```

2. Get dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Demo Credentials

For testing the authentication flow:
- **Email**: any valid email format (e.g., test@example.com)
- **Password**: at least 6 characters
- **OTP Code**: 1234 (mock verification)

## Features in Detail

### Authentication Flow
1. Start at Login screen
2. Sign up for new account → OTP verification → Product screen
3. Login with credentials → Product screen
4. Navigate to Settings → Logout (returns to Login screen)

### Product Browsing
- View all products in the Products tab
- Tap any product to see detailed information
- Add products to cart (shows snackbar confirmation)
- Switch between categories using the Categories tab

### Categories
- Filter products by category using chips at the top
- Selected category is highlighted in blue
- Products update instantly when category changes

### Settings
- Toggle dark/light mode (UI prepared for theme switching)
- View app version and current theme status
- Logout securely with confirmation

## API Integration Ready

The mock data and network calls can be easily replaced with real API calls:
- Replace `mockProducts` list with API calls in product screens
- Replace mock authentication with real backend calls
- Replace mock OTP with real SMS/email service
- Implement real theme persistence with shared preferences

## Future Enhancements

- [ ] Real API integration (backend connection)
- [ ] User profile management
- [ ] Shopping cart persistence
- [ ] Order history
- [ ] Wishlist functionality
- [ ] Search and filtering
- [ ] Payment gateway integration
- [ ] Push notifications
- [ ] Theme persistence with shared preferences

## License

This project is created for educational purposes.

## Author

Ahmed Walid
GitHub: [@ahmeddwwalid](https://github.com/ahmeddwwalid)

---

**Note**: This is a demo app. Replace all mock data and authentication with real API calls before deploying to production.
