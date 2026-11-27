# Calley Mobile Application

A Flutter application developed based on the Figma design specifications and integrated with the Calley Mock REST API.

---

## Features and Application Flow

1. **Language Selection Screen (`01_language_screen.dart`)**
   - Radio button language selection.
   - Saves selection and proceeds to user onboarding.

2. **Sign Up Screen (`02_sign_up_screen.dart`)**
   - User registration form (Name, Email, Password, Phone Number).
   - Terms and Conditions agreement check.
   - API integration with `/auth/send-otp`.
   - Direct navigation to Sign In screen for existing users.
   - Tap-to-unfocus gesture support to dismiss keyboard.

3. **OTP Verification Screen (`03_verify_screen.dart`)**
   - 6-digit individual input fields with automatic focus progression and backspace handling.
   - API integration with `/auth/verify-otp`.
   - Resend OTP functionality displaying test credentials.
   - Tap-to-unfocus gesture support to dismiss keyboard.

4. **Sign In Screen (`04_sign_in_screen.dart`)**
   - Authentication using registered test credentials.
   - API integration with `/auth/login`.
   - Tap-to-unfocus gesture support to dismiss keyboard.

5. **Welcome Video Screen (`05_welcome_video_screen.dart`)**
   - Embedded video preview container.
   - External URL launcher integration to play introductory video.

6. **Dashboard / Load Number Screen (`06_load_number_screen.dart`)**
   - User profile greeting with dynamic username from session.
   - Instructions and link to web panel (`https://app.getcalley.com`) using responsive inline text formatting.
   - Side drawer menu (`AppDrawerLeft`) and bottom navigation bar.

7. **Calling Lists Screen (`07_bottom_sheet_screen.dart`)**
   - Bottom sheet interface displaying available calling lists.
   - API integration with `/list?userId={userId}`.
   - Refresh list trigger and item selection.

8. **Dashboard Statistics Screen (`08_dashboard_stats_screen.dart`)**
   - API integration with `/list/{listId}` to retrieve call metrics.
   - Circular donut chart rendering metrics using `fl_chart`.
   - Key metrics display: Total Calls, Pending, Called, and Rescheduled.
   - Complete navigation controls and side drawer.

---

## Test Credentials

The backend utilizes pre-seeded test data:

- **Email**: `dhrubo@yopmail.com`
- **Password**: `123`
- **OTP**: `229166`
- **User ID**: `68626f9497757cb741f449b0`
- **List ID**: `68626fb697757cb741f449b9`

---

## API Configuration

- **Base URL**: `https://mock-api.calleyacd.com/api`
- **SSL Certificate Handling**: Handled via custom `HttpOverrides` in `lib/main.dart` to bypass mock server hostname mismatch.

---

## Getting Started

### Prerequisites
- Flutter SDK (version 3.14.0 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extension
- An active Android emulator, iOS simulator, or physical device

### Installation and Execution

1. Clone or extract the project directory:
   ```bash
   cd test_project
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the application:
   ```bash
   flutter run
   ```

4. Execute unit and widget tests:
   ```bash
   flutter test
   ```

---

## Project Structure

```
lib/
├── api/
│   └── api_service.dart          # HTTP client and Mock API endpoints
├── model/
│   └── list_model.dart           # Data models for lists and statistics
├── reusable_widgets/
│   ├── core/
│   │   ├── app_colors.dart       # Design system color constants
│   │   ├── app_spacing.dart      # Standardized spacing helpers
│   │   └── app_text_styles.dart  # Typography styles
│   └── shared/
│       ├── app_button.dart       # Reusable button component
│       ├── app_container.dart    # Styled wrapper container
│       ├── app_drawer_left.dart  # Navigation drawer
│       └── app_text_field.dart   # Outlined text input field
├── ui/
│   └── screens/                  # 8 sequential screens per Figma specs
└── main.dart                     # App entrypoint and network overrides
```
